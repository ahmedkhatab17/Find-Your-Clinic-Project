// Pure Dart — no Flutter imports.

/// Stable intent identifiers returned by the backend (must stay in sync with
/// the SystemPrompt in `ProcessVoiceCommandHandler.cs` on the .NET side).
abstract class VoiceIntentIds {
  VoiceIntentIds._();

  static const navigateHome = 'navigate_home';
  static const navigateAppointments = 'navigate_appointments';
  static const navigateSearch = 'navigate_search';
  static const navigateNearbyClinics = 'navigate_nearby_clinics';
  static const navigateProfile = 'navigate_profile';
  static const navigateAiChat = 'navigate_ai_chat';
  static const navigateNotifications = 'navigate_notifications';
  static const navigateHealthRecords = 'navigate_health_records';
  static const bookAppointment = 'book_appointment';
  static const readNextAppointment = 'read_next_appointment';
  static const readAllUpcomingAppointments = 'read_all_upcoming_appointments';
  static const readScreen = 'read_screen';
  static const selectItem = 'select_item';
  static const goBack = 'go_back';
  static const help = 'help';
  static const cancel = 'cancel';
  static const unknown = 'unknown';
}

/// Sealed intent hierarchy. Carries optional parameters extracted by Gemini.
sealed class VoiceCommandIntent {
  const VoiceCommandIntent();
}

class NavigateHomeIntent extends VoiceCommandIntent {
  const NavigateHomeIntent();
}

class NavigateAppointmentsIntent extends VoiceCommandIntent {
  const NavigateAppointmentsIntent();
}

class NavigateSearchIntent extends VoiceCommandIntent {
  /// Optional free-text query Gemini extracted (e.g. "cardiologist").
  final String? query;
  const NavigateSearchIntent({this.query});
}

class NavigateNearbyClinicsIntent extends VoiceCommandIntent {
  const NavigateNearbyClinicsIntent();
}

class NavigateProfileIntent extends VoiceCommandIntent {
  const NavigateProfileIntent();
}

class NavigateAiChatIntent extends VoiceCommandIntent {
  const NavigateAiChatIntent();
}

class NavigateNotificationsIntent extends VoiceCommandIntent {
  const NavigateNotificationsIntent();
}

class NavigateHealthRecordsIntent extends VoiceCommandIntent {
  const NavigateHealthRecordsIntent();
}

class BookAppointmentIntent extends VoiceCommandIntent {
  final String? doctorName;
  final String? specialty;
  const BookAppointmentIntent({this.doctorName, this.specialty});
}

class ReadNextAppointmentIntent extends VoiceCommandIntent {
  const ReadNextAppointmentIntent();
}

class ReadAllUpcomingAppointmentsIntent extends VoiceCommandIntent {
  const ReadAllUpcomingAppointmentsIntent();
}

/// Speak a summary of the current screen aloud.
class ReadScreenIntent extends VoiceCommandIntent {
  const ReadScreenIntent();
}

/// Select item by 1-based ordinal from a list visible on the current screen.
class SelectItemIntent extends VoiceCommandIntent {
  final int index;
  const SelectItemIntent(this.index);
}

class GoBackIntent extends VoiceCommandIntent {
  const GoBackIntent();
}

class HelpIntent extends VoiceCommandIntent {
  const HelpIntent();
}

class CancelIntent extends VoiceCommandIntent {
  const CancelIntent();
}

class UnknownIntent extends VoiceCommandIntent {
  final String originalText;
  const UnknownIntent(this.originalText);
}
