import '../../domain/entities/voice_command_intent.dart';
import '../../domain/entities/voice_command_result.dart';

/// Wire-format model for the backend's voice-command response.
class VoiceCommandResponseModel {
  final String intent;
  final Map<String, dynamic> parameters;
  final String spokenResponse;

  const VoiceCommandResponseModel({
    required this.intent,
    required this.parameters,
    required this.spokenResponse,
  });

  factory VoiceCommandResponseModel.fromJson(Map<String, dynamic> json) {
    final rawParams = json['parameters'];
    return VoiceCommandResponseModel(
      intent: (json['intent'] as String?) ?? VoiceIntentIds.unknown,
      parameters: rawParams is Map
          ? Map<String, dynamic>.from(rawParams)
          : const <String, dynamic>{},
      spokenResponse: (json['spokenResponse'] as String?) ?? '',
    );
  }

  /// Convert the wire model into the strongly-typed domain result. Falls back
  /// to [UnknownIntent] if the backend returns an id we don't recognize.
  VoiceCommandResult toEntity({required String originalTranscript}) {
    final intent = _toIntent(originalTranscript);
    return VoiceCommandResult(
      intent: intent,
      spokenResponse: spokenResponse,
    );
  }

  VoiceCommandIntent _toIntent(String originalTranscript) {
    switch (intent) {
      case VoiceIntentIds.navigateHome:
        return const NavigateHomeIntent();
      case VoiceIntentIds.navigateAppointments:
        return const NavigateAppointmentsIntent();
      case VoiceIntentIds.navigateSearch:
        return NavigateSearchIntent(query: parameters['query'] as String?);
      case VoiceIntentIds.navigateNearbyClinics:
        return const NavigateNearbyClinicsIntent();
      case VoiceIntentIds.navigateProfile:
        return const NavigateProfileIntent();
      case VoiceIntentIds.navigateAiChat:
        return const NavigateAiChatIntent();
      case VoiceIntentIds.navigateNotifications:
        return const NavigateNotificationsIntent();
      case VoiceIntentIds.navigateHealthRecords:
        return const NavigateHealthRecordsIntent();
      case VoiceIntentIds.navigateConversations:
        return const NavigateConversationsIntent();
      case VoiceIntentIds.navigateEditProfile:
        return const NavigateEditProfileIntent();
      case VoiceIntentIds.bookAppointment:
        return BookAppointmentIntent(
          doctorName: parameters['doctorName'] as String?,
          specialty: parameters['specialty'] as String?,
        );
      case VoiceIntentIds.readNextAppointment:
        return const ReadNextAppointmentIntent();
      case VoiceIntentIds.readAllUpcomingAppointments:
        return const ReadAllUpcomingAppointmentsIntent();
      case VoiceIntentIds.readScreen:
        return const ReadScreenIntent();
      case VoiceIntentIds.selectItem:
        final raw = parameters['index'];
        final idx = raw is int
            ? raw
            : raw is num
                ? raw.toInt()
                : int.tryParse('${raw ?? ''}') ?? 0;
        return SelectItemIntent(idx);
      case VoiceIntentIds.goBack:
        return const GoBackIntent();
      case VoiceIntentIds.help:
        return const HelpIntent();
      case VoiceIntentIds.cancel:
        return const CancelIntent();
      case VoiceIntentIds.confirm:
        return const ConfirmIntent();
      case VoiceIntentIds.deny:
        return const DenyIntent();
      default:
        return UnknownIntent(originalTranscript);
    }
  }
}
