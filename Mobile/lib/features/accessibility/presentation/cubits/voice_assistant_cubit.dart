import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/locale/locale_cubit.dart';
import '../../../ai_health/presentation/cubits/voice_input_cubit.dart';
import '../../../ai_health/presentation/cubits/voice_input_state.dart';
import '../../../appointments/domain/entities/appointment_entity.dart';
import '../../../appointments/domain/usecases/appointment_usecases.dart';
import '../../domain/entities/screen_context.dart';
import '../../domain/entities/voice_command_intent.dart';
import '../../domain/entities/voice_command_result.dart';
import '../../domain/usecases/process_voice_command_usecase.dart';
import 'voice_assistant_state.dart';

/// Called by the cubit when a navigation intent is recognized. The widget
/// resolves the actual `context.go(...)` so the cubit stays free of
/// `BuildContext` and `GoRouter`.
typedef VoiceIntentHandler = Future<void> Function(VoiceCommandIntent intent);

/// Producer of a short, TTS-friendly summary of the current screen.
/// Returning an empty string makes the assistant fall back to "Nothing to read".
typedef ScreenSummaryProvider = String Function();

/// Selects an item by 1-based ordinal from the list visible on the current
/// screen. Returns `true` when the screen handled the selection (so the cubit
/// can stay quiet) or `false` when the screen could not (so the cubit will
/// speak a friendly fallback).
typedef ItemSelector = bool Function(int oneBasedIndex);

/// Orchestrates the blind-patient voice assistant: listen → call Gemini →
/// speak + act.
///
/// Subscribes to the existing [VoiceInputCubit] for STT, sends the transcript
/// (with the active screen's context) to the backend `/api/ai/voice-command`
/// endpoint, and either speaks a response via [TtsService] or defers
/// navigation to a handler injected by the host widget.
class VoiceAssistantCubit extends Cubit<VoiceAssistantState> {
  final VoiceInputCubit _voice;
  final TtsService _tts;
  final ProcessVoiceCommandUseCase _processVoiceCommand;
  final GetPatientAppointmentsUseCase _getAppointments;
  final BookAppointmentUseCase _bookAppointment;

  StreamSubscription<VoiceInputState>? _voiceSub;
  StreamSubscription<bool>? _ttsSub;
  VoiceIntentHandler? _navigationHandler;

  ScreenContext _currentContext = ScreenContext.unknown;
  ScreenSummaryProvider? _screenSummary;
  ItemSelector? _itemSelector;

  AppLocalizations get _l10n {
    final code = sl<LocaleCubit>().effectiveLanguageCode;
    return lookupAppLocalizations(Locale(code));
  }

  VoiceAssistantCubit({
    required VoiceInputCubit voiceInputCubit,
    required TtsService tts,
    required ProcessVoiceCommandUseCase processVoiceCommand,
    required GetPatientAppointmentsUseCase getAppointments,
    required BookAppointmentUseCase bookAppointment,
  })  : _voice = voiceInputCubit,
        _tts = tts,
        _processVoiceCommand = processVoiceCommand,
        _getAppointments = getAppointments,
        _bookAppointment = bookAppointment,
        super(const VoiceAssistantIdle()) {
    _voiceSub = _voice.stream.listen(_onVoiceState);
    // When TTS finishes, drop transient Spoken/Error states back to Idle
    // so the home card and FAB show "Tap to talk" again instead of lingering
    // on the spoken caption forever.
    _ttsSub = _tts.isSpeaking.listen((isSpeaking) {
      if (isClosed || isSpeaking) return;
      final s = state;
      if (s is VoiceAssistantSpoken || s is VoiceAssistantError) {
        emit(const VoiceAssistantIdle());
      }
    });
  }

  /// Wired once by the patient shell — the only widget that knows the router.
  void attachNavigationHandler(VoiceIntentHandler handler) {
    _navigationHandler = handler;
  }

  /// Each patient screen calls this in `initState` (and clears in `dispose`)
  /// so commands like "read this screen" or "select the second one" know
  /// where the user is.
  void setScreenContext(
    ScreenContext context, {
    ScreenSummaryProvider? summary,
    ItemSelector? itemSelector,
  }) {
    _currentContext = context;
    _screenSummary = summary;
    _itemSelector = itemSelector;
  }

  void clearScreenContext(ScreenContext context) {
    if (_currentContext.screen == context.screen) {
      _currentContext = ScreenContext.unknown;
      _screenSummary = null;
      _itemSelector = null;
    }
  }

  Future<void> startListening() async {
    if (state is VoiceAssistantListening) return;
    await _tts.stop(); // never let TTS overlap STT or we get audio feedback
    emit(const VoiceAssistantListening());
    await _voice.startListening();
  }

  Future<void> cancel() async {
    await _voice.cancelListening();
    await _tts.stop();
    emit(const VoiceAssistantIdle());
  }

  void _onVoiceState(VoiceInputState s) {
    switch (s) {
      case VoiceListening():
        emit(VoiceAssistantListening(
          partialTranscript: s.transcript,
          soundLevel: s.soundLevel,
        ));
      case VoiceResult():
        unawaited(_handleTranscript(s.text));
      case VoiceError():
        emit(VoiceAssistantError(s.message));
        unawaited(_tts.speak(s.message));
      case VoiceIdle():
        // No-op — final transitions are driven by _handleTranscript / cancel.
        break;
    }
  }

  Future<void> _handleTranscript(String text) async {
    // STT often emits an empty final transcript on timeout / silence. Just
    // drop back to idle silently — speaking an apology every time the user
    // briefly hesitates is intrusive.
    if (text.trim().isEmpty) {
      emit(const VoiceAssistantIdle());
      return;
    }
    emit(VoiceAssistantThinking(text));

    final result = await _processVoiceCommand(
      transcript: text,
      context: _currentContext,
    );

    switch (result) {
      case Success<VoiceCommandResult>(:final data):
        await _executeIntent(data);
      case Error<VoiceCommandResult>():
        await _speak(_l10n.voiceAssistantCouldNotReach);
    }
  }

  Future<void> _executeIntent(VoiceCommandResult result) async {
    final spoken = result.spokenResponse.trim();
    final intent = result.intent;

    switch (intent) {
      case ReadScreenIntent():
        final summary = _screenSummary?.call().trim() ?? '';
        await _speak(
          summary.isNotEmpty ? summary : _l10n.voiceAssistantNothingToRead,
        );

      case SelectItemIntent(:final index):
        final selector = _itemSelector;
        if (selector == null) {
          await _speak(_l10n.voiceAssistantNothingToSelect);
          break;
        }
        final ok = selector(index);
        if (!ok) {
          await _speak(_l10n.voiceAssistantItemNotFound(index));
        } else if (spoken.isNotEmpty) {
          await _speak(spoken);
        }

      case ReadNextAppointmentIntent():
        await _speakNextAppointment();

      case ReadAllUpcomingAppointmentsIntent():
        await _speakAllUpcomingAppointments();

      case BookAppointmentIntent():
        // If the user is standing on a doctor's profile, book the next
        // available slot directly as a cash-in-clinic appointment — blind
        // patients shouldn't have to navigate the multi-step booking UI.
        if (_currentContext.screen == PatientScreen.doctorProfile &&
            _hasBookableDoctor()) {
          await _quickBookCashFromContext();
        } else {
          if (spoken.isNotEmpty) await _speak(spoken);
          await _navigationHandler?.call(intent);
        }

      case GoBackIntent():
      case NavigateHomeIntent():
      case NavigateAppointmentsIntent():
      case NavigateSearchIntent():
      case NavigateNearbyClinicsIntent():
      case NavigateProfileIntent():
      case NavigateAiChatIntent():
      case NavigateNotificationsIntent():
      case NavigateHealthRecordsIntent():
      case NavigateConversationsIntent():
      case NavigateEditProfileIntent():
        if (spoken.isNotEmpty) await _speak(spoken);
        await _navigationHandler?.call(intent);
        // Auto-speak the new screen's summary so the blind user knows
        // where they landed. We wait briefly to let the destination
        // screen register its ScreenSummaryProvider in initState.
        unawaited(_autoSpeakAfterNavigation());

      case HelpIntent():
        await _speak(spoken.isNotEmpty ? spoken : _helpMessage());

      case CancelIntent():
        await _speak(spoken.isNotEmpty ? spoken : _l10n.voiceAssistantCancelled);

      case ConfirmIntent():
      case DenyIntent():
        if (spoken.isNotEmpty) await _speak(spoken);

      case UnknownIntent():
        await _speak(
          spoken.isNotEmpty
              ? spoken
              : _l10n.voiceAssistantDidNotUnderstand,
        );
    }
  }

  bool _hasBookableDoctor() {
    final d = _currentContext.data;
    return d[ScreenContextKeys.doctorProfileId] is String &&
        d[ScreenContextKeys.nextAvailableSlotIso] is String;
  }

  /// Books the doctor's next available slot as a cash-in-clinic appointment.
  /// Speaks the confirmation aloud — no further screens or payment UI.
  Future<void> _quickBookCashFromContext() async {
    final d = _currentContext.data;
    final doctorProfileId = d[ScreenContextKeys.doctorProfileId] as String?;
    final slotIso = d[ScreenContextKeys.nextAvailableSlotIso] as String?;
    final doctorName =
        (d[ScreenContextKeys.doctorName] as String?)?.trim() ?? '';
    final clinic = (d[ScreenContextKeys.clinicName] as String?)?.trim();

    if (doctorProfileId == null || slotIso == null) {
      await _speak(_l10n.voiceAssistantNeedDoctorProfile);
      return;
    }

    final scheduledAt = DateTime.tryParse(slotIso);
    if (scheduledAt == null) {
      await _speak(_l10n.voiceAssistantCouldNotReadSlot);
      return;
    }

    final friendlyName = doctorName.isNotEmpty ? doctorName : 'doctor';
    await _speak(_l10n.voiceAssistantBookingSlot(friendlyName));

    final result = await _bookAppointment(
      doctorProfileId: doctorProfileId,
      scheduledAt: scheduledAt,
      locationName: clinic,
    );

    switch (result) {
      case Success<AppointmentEntity>(:final data):
        final code = sl<LocaleCubit>().effectiveLanguageCode;
        final dateStr = DateFormat('EEEE, MMMM d', code).format(data.scheduledAt);
        final timeStr = DateFormat('h:mm a', code).format(data.scheduledAt);
        await _speak(_l10n.voiceAssistantBookingDone(friendlyName, dateStr, timeStr));
      case Error<AppointmentEntity>(:final failure):
        await _speak(_l10n.voiceAssistantBookingFailed(failure.message));
    }
  }

  Future<void> _speakNextAppointment() async {
    final result = await _getAppointments();
    switch (result) {
      case Success<List<AppointmentEntity>>(:final data):
        final next = _findNextUpcoming(data);
        if (next == null) {
          await _speak(_l10n.voiceAssistantNoUpcoming);
          return;
        }
        await _speak(_formatAppointmentSentence(next, prefix: _l10n.voiceAssistantNextAppointment));
      case Error<List<AppointmentEntity>>():
        await _speak(_l10n.voiceAssistantCouldNotLoad);
    }
  }

  Future<void> _speakAllUpcomingAppointments() async {
    final result = await _getAppointments();
    if (result is Error<List<AppointmentEntity>>) {
      await _speak(_l10n.voiceAssistantCouldNotLoad);
      return;
    }
    final upcoming = (result as Success<List<AppointmentEntity>>)
        .data
        .where((a) => a.isUpcoming)
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    if (upcoming.isEmpty) {
      await _speak(_l10n.voiceAssistantNoUpcoming);
      return;
    }
    final buffer = StringBuffer(_l10n.voiceAssistantUpcomingCount(upcoming.length));
    for (var i = 0; i < upcoming.length; i++) {
      buffer.write(
        _formatAppointmentSentence(upcoming[i], prefix: '${i + 1}.'),
      );
      buffer.write('. ');
    }
    await _speak(buffer.toString());
  }

  AppointmentEntity? _findNextUpcoming(List<AppointmentEntity> all) {
    final upcoming = all.where((a) => a.isUpcoming).toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return upcoming.isEmpty ? null : upcoming.first;
  }

  String _formatAppointmentSentence(
    AppointmentEntity appt, {
    required String prefix,
  }) {
    final code = sl<LocaleCubit>().effectiveLanguageCode;
    final dateStr = DateFormat('EEEE, MMMM d', code).format(appt.scheduledAt);
    final timeStr = DateFormat('h:mm a', code).format(appt.scheduledAt);
    final onStr = _l10n.voiceAssistantAppointmentOn(dateStr, timeStr);
    final doctor = appt.relatedPersonName.trim().isNotEmpty
        ? _l10n.voiceAssistantWithDoctor(appt.relatedPersonName)
        : '';
    return '$prefix $onStr$doctor';
  }

  Future<void> _speak(String message) async {
    final localeCode = sl<LocaleCubit>().effectiveLanguageCode;
    await _tts.setLanguage(localeCode);
    emit(VoiceAssistantSpoken(message));
    await _tts.speak(message);
  }

  /// Waits briefly for the destination screen to register its
  /// [ScreenSummaryProvider] via [setScreenContext], then speaks the summary.
  Future<void> _autoSpeakAfterNavigation() async {
    // Wait for the new screen's initState + addPostFrameCallback to fire.
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (isClosed) return;

    final summary = _screenSummary?.call().trim() ?? '';
    if (summary.isNotEmpty) {
      await _speak(summary);
    }
  }

  String _helpMessage() => _l10n.voiceAssistantHelpMessage;

  @override
  Future<void> close() async {
    await _voiceSub?.cancel();
    await _ttsSub?.cancel();
    await _tts.stop();
    return super.close();
  }
}
