import '../../domain/entities/doctor_dashboard_entities.dart';

/// Sealed state for DoctorHomeCubit.
sealed class DoctorHomeState {
  const DoctorHomeState();
}

class DoctorHomeInitial extends DoctorHomeState {}

class DoctorHomeLoading extends DoctorHomeState {}

class DoctorHomeLoaded extends DoctorHomeState {
  final DoctorDashboard dashboard;
  const DoctorHomeLoaded(this.dashboard);
}

class DoctorHomeError extends DoctorHomeState {
  final String message;
  const DoctorHomeError(this.message);
}
