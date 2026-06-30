import 'package:flutter/widgets.dart';
import '../../l10n/generated/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String translateDay(String dayName) {
    switch (dayName.toLowerCase()) {
      case 'monday': return l10n.dayMonday;
      case 'tuesday': return l10n.dayTuesday;
      case 'wednesday': return l10n.dayWednesday;
      case 'thursday': return l10n.dayThursday;
      case 'friday': return l10n.dayFriday;
      case 'saturday': return l10n.daySaturday;
      case 'sunday': return l10n.daySunday;
      default: return dayName;
    }
  }

  String? translateNotificationTitle(String? type) {
    switch (type) {
      case 'doctor_approved': return l10n.notifTitleDoctorApproved;
      case 'doctor_rejected': return l10n.notifTitleDoctorRejected;
      case 'appointment_booked': return l10n.notifTitleAppointmentBooked;
      case 'appointment_confirmed': return l10n.notifTitleAppointmentConfirmed;
      case 'appointment_cancelled': return l10n.notifTitleAppointmentCancelled;
      case 'appointment_reminder': return l10n.notifTitleAppointmentReminder;
      case 'appointment_completed': return l10n.notifTitleAppointmentCompleted;
      case 'new_message': return l10n.notifTitleNewMessage;
      case 'new_review': return l10n.notifTitleNewReview;
      case 'doctor_activated': return l10n.notifTitleDoctorActivated;
      case 'doctor_deactivated': return l10n.notifTitleDoctorDeactivated;
      default: return null;
    }
  }

  String? translateNotificationBody(String? type) {
    switch (type) {
      case 'doctor_approved': return l10n.notifBodyDoctorApproved;
      case 'doctor_rejected': return l10n.notifBodyDoctorRejected;
      case 'appointment_booked': return l10n.notifBodyAppointmentBooked;
      case 'appointment_confirmed': return l10n.notifBodyAppointmentConfirmed;
      case 'appointment_cancelled': return l10n.notifBodyAppointmentCancelled;
      case 'appointment_reminder': return l10n.notifBodyAppointmentReminder;
      case 'appointment_completed': return l10n.notifBodyAppointmentCompleted;
      case 'new_message': return l10n.notifBodyNewMessage;
      case 'new_review': return l10n.notifBodyNewReview;
      case 'doctor_activated': return l10n.notifBodyDoctorActivated;
      case 'doctor_deactivated': return l10n.notifBodyDoctorDeactivated;
      default: return null;
    }
  }
}
