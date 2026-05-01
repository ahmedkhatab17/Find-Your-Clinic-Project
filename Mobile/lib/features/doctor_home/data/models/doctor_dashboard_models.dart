import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/doctor_dashboard_entities.dart';

/// JSON deserialization models for the doctor dashboard API.

class DoctorDashboardModel {
  final QuickStatsModel quickStats;
  final NextAppointmentModel? nextAppointment;
  final PerformanceModel performance;
  final List<ScheduleItemModel> todaySchedule;

  const DoctorDashboardModel({
    required this.quickStats,
    this.nextAppointment,
    required this.performance,
    required this.todaySchedule,
  });

  factory DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    return DoctorDashboardModel(
      quickStats: QuickStatsModel.fromJson(json['quickStats']),
      nextAppointment: json['nextAppointment'] != null
          ? NextAppointmentModel.fromJson(json['nextAppointment'])
          : null,
      performance: PerformanceModel.fromJson(json['performance']),
      todaySchedule: (json['todaySchedule'] as List)
          .map((e) => ScheduleItemModel.fromJson(e))
          .toList(),
    );
  }

  DoctorDashboard toEntity() => DoctorDashboard(
        quickStats: quickStats.toEntity(),
        nextAppointment: nextAppointment?.toEntity(),
        performance: performance.toEntity(),
        todaySchedule: todaySchedule.map((e) => e.toEntity()).toList(),
      );
}

class QuickStatsModel {
  final int totalToday;
  final int completed;
  final int pending;
  final int cancelled;

  const QuickStatsModel({
    required this.totalToday,
    required this.completed,
    required this.pending,
    required this.cancelled,
  });

  factory QuickStatsModel.fromJson(Map<String, dynamic> json) {
    return QuickStatsModel(
      totalToday: json['totalToday'] ?? 0,
      completed: json['completed'] ?? 0,
      pending: json['pending'] ?? 0,
      cancelled: json['cancelled'] ?? 0,
    );
  }

  QuickStats toEntity() => QuickStats(
        totalToday: totalToday,
        completed: completed,
        pending: pending,
        cancelled: cancelled,
      );
}

class NextAppointmentModel {
  final String appointmentId;
  final DateTime scheduledAt;
  final String status;
  final String? locationName;
  final String patientId;
  final String patientName;
  final String? patientImageUrl;

  const NextAppointmentModel({
    required this.appointmentId,
    required this.scheduledAt,
    required this.status,
    this.locationName,
    required this.patientId,
    required this.patientName,
    this.patientImageUrl,
  });

  factory NextAppointmentModel.fromJson(Map<String, dynamic> json) {
    return NextAppointmentModel(
      appointmentId: json['appointmentId'],
      scheduledAt: parseServerDateTime(json['scheduledAt']),
      status: json['status'],
      locationName: json['locationName'],
      patientId: json['patientId'],
      patientName: json['patientName'],
      patientImageUrl: json['patientImageUrl'],
    );
  }

  NextAppointment toEntity() => NextAppointment(
        appointmentId: appointmentId,
        scheduledAt: scheduledAt,
        status: status,
        locationName: locationName,
        patientId: patientId,
        patientName: patientName,
        patientImageUrl: patientImageUrl,
      );
}

class PerformanceModel {
  final int patientsThisMonth;
  final double averageRating;
  final int totalReviews;

  const PerformanceModel({
    required this.patientsThisMonth,
    required this.averageRating,
    required this.totalReviews,
  });

  factory PerformanceModel.fromJson(Map<String, dynamic> json) {
    return PerformanceModel(
      patientsThisMonth: json['patientsThisMonth'] ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      totalReviews: json['totalReviews'] ?? 0,
    );
  }

  PerformanceSummary toEntity() => PerformanceSummary(
        patientsThisMonth: patientsThisMonth,
        averageRating: averageRating,
        totalReviews: totalReviews,
      );
}

class ScheduleItemModel {
  final String appointmentId;
  final DateTime scheduledAt;
  final String status;
  final String patientId;
  final String patientName;
  final String? patientImageUrl;

  const ScheduleItemModel({
    required this.appointmentId,
    required this.scheduledAt,
    required this.status,
    required this.patientId,
    required this.patientName,
    this.patientImageUrl,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    return ScheduleItemModel(
      appointmentId: json['appointmentId'],
      scheduledAt: parseServerDateTime(json['scheduledAt']),
      status: json['status'],
      patientId: json['patientId'],
      patientName: json['patientName'],
      patientImageUrl: json['patientImageUrl'],
    );
  }

  ScheduleItem toEntity() => ScheduleItem(
        appointmentId: appointmentId,
        scheduledAt: scheduledAt,
        status: status,
        patientId: patientId,
        patientName: patientName,
        patientImageUrl: patientImageUrl,
      );
}
