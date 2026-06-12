import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/accessibility_preferences_store.dart';

/// Emits whether the voice-assistant card is visible on the patient home
/// screen. Shared between the home screen and the Settings toggle so changes
/// reflect immediately on both surfaces.
class VoiceAssistantVisibilityCubit extends Cubit<bool> {
  final AccessibilityPreferencesStore _store;

  VoiceAssistantVisibilityCubit(this._store) : super(false) {
    _hydrate();
  }

  Future<void> _hydrate() async {
    final value = await _store.isVoiceCardEnabled();
    if (!isClosed) emit(value);
  }

  Future<void> dismiss() async {
    emit(false);
    await _store.setVoiceCardEnabled(false);
  }

  Future<void> enable() async {
    emit(true);
    await _store.setVoiceCardEnabled(true);
  }

  Future<void> setEnabled(bool value) =>
      value ? enable() : dismiss();
}
