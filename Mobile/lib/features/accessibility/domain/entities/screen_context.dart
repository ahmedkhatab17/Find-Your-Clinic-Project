// Pure Dart — no Flutter imports.
import 'dart:convert';

/// Identifier for the patient screen the user is currently on. Sent to the
/// backend so Gemini can interpret context-sensitive commands like
/// "read this screen" or "select the second one".
enum PatientScreen {
  home,
  appointments,
  appointmentDetail,
  searchResults,
  doctorProfile,
  bookAppointment,
  checkout,
  profile,
  notifications,
  healthRecords,
  aiChat,
  nearbyClinics,
  settings,
  unknown,
}

extension PatientScreenLabel on PatientScreen {
  /// Human-readable label sent to Gemini and used for TTS announcements.
  String get label => switch (this) {
        PatientScreen.home => 'home',
        PatientScreen.appointments => 'appointments',
        PatientScreen.appointmentDetail => 'appointment_detail',
        PatientScreen.searchResults => 'search_results',
        PatientScreen.doctorProfile => 'doctor_profile',
        PatientScreen.bookAppointment => 'book_appointment',
        PatientScreen.checkout => 'checkout',
        PatientScreen.profile => 'profile',
        PatientScreen.notifications => 'notifications',
        PatientScreen.healthRecords => 'health_records',
        PatientScreen.aiChat => 'ai_chat',
        PatientScreen.nearbyClinics => 'nearby_clinics',
        PatientScreen.settings => 'settings',
        PatientScreen.unknown => 'unknown',
      };
}

/// Stable keys for [ScreenContext.data] entries that the voice assistant
/// reads. Defining them here keeps the publisher (the screen) and the
/// consumer (the cubit) in lock-step.
abstract class ScreenContextKeys {
  ScreenContextKeys._();

  // Doctor profile screen
  static const doctorProfileId = 'doctorProfileId';
  static const doctorUserId = 'doctorUserId';
  static const doctorName = 'doctorName';
  static const doctorSpecialty = 'doctorSpecialty';
  static const consultationFee = 'consultationFee';
  static const clinicName = 'clinicName';
  static const nextAvailableSlotIso = 'nextAvailableSlotIso';
}

/// Optional structured context the screen can publish for Gemini (e.g. a list
/// of items currently on screen so the user can say "select the second one").
class ScreenContext {
  final PatientScreen screen;
  final Map<String, Object?> data;

  const ScreenContext({required this.screen, this.data = const {}});

  static const ScreenContext unknown =
      ScreenContext(screen: PatientScreen.unknown);

  String? toJsonOrNull() {
    if (data.isEmpty) return null;
    return jsonEncode(data);
  }
}
