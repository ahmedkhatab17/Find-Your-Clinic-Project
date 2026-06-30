import 'package:flutter/widgets.dart';
import '../../features/appointments/domain/entities/appointment_entity.dart';
import '../locale/l10n_extension.dart';

extension AppointmentStatusL10nExtension on AppointmentStatus {
  String getLocalizedLabel(BuildContext context, bool isDoctor) {
    final l10n = context.l10n;
    if (isDoctor) {
      return switch (this) {
        AppointmentStatus.scheduled => l10n.appointmentStatusNewRequest,
        AppointmentStatus.confirmed => l10n.appointmentStatusConfirmed,
        AppointmentStatus.cancelled => l10n.appointmentStatusCancelled,
        AppointmentStatus.completed => l10n.appointmentStatusCompleted,
        AppointmentStatus.pendingPayment => l10n.appointmentStatusCashPending,
      };
    } else {
      return switch (this) {
        AppointmentStatus.scheduled => l10n.appointmentStatusPending,
        AppointmentStatus.confirmed => l10n.appointmentStatusConfirmed,
        AppointmentStatus.cancelled => l10n.appointmentStatusCancelled,
        AppointmentStatus.completed => l10n.appointmentStatusCompleted,
        AppointmentStatus.pendingPayment => l10n.appointmentStatusAwaitingApproval,
      };
    }
  }
}
