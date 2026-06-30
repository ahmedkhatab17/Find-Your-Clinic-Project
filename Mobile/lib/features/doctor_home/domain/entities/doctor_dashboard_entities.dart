// Domain entities for the doctor dashboard.
// Pure Dart — no Flutter imports.

class DoctorDashboard {
  final String doctorName;
  final QuickStats quickStats;
  final OverallStats overallStats;
  final NextAppointment? nextAppointment;
  final PerformanceSummary performance;
  final List<ScheduleItem> todaySchedule;

  const DoctorDashboard({
    required this.doctorName,
    required this.quickStats,
    required this.overallStats,
    this.nextAppointment,
    required this.performance,
    required this.todaySchedule,
  });
}

class QuickStats {
  final int totalToday;
  final int completed;
  final int pending;
  final int cancelled;

  const QuickStats({
    required this.totalToday,
    required this.completed,
    required this.pending,
    required this.cancelled,
  });
}

class OverallStats {
  final int total;
  final int completed;
  final int pending;
  final int cancelled;

  const OverallStats({
    required this.total,
    required this.completed,
    required this.pending,
    required this.cancelled,
  });
}

class NextAppointment {
  final String appointmentId;
  final DateTime scheduledAt;
  final String status;
  final String? locationName;
  final String patientId;
  final String patientName;
  final String? patientImageUrl;

  const NextAppointment({
    required this.appointmentId,
    required this.scheduledAt,
    required this.status,
    this.locationName,
    required this.patientId,
    required this.patientName,
    this.patientImageUrl,
  });
}

class PerformanceSummary {
  final int totalPatients;
  final double averageRating;
  final int totalReviews;

  const PerformanceSummary({
    required this.totalPatients,
    required this.averageRating,
    required this.totalReviews,
  });
}

class ScheduleItem {
  final String appointmentId;
  final DateTime scheduledAt;
  final String status;
  final String patientId;
  final String patientName;
  final String? patientImageUrl;

  const ScheduleItem({
    required this.appointmentId,
    required this.scheduledAt,
    required this.status,
    required this.patientId,
    required this.patientName,
    this.patientImageUrl,
  });
}
