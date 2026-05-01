import '../../domain/entities/user_profile_entity.dart';

sealed class PatientProfileState {}

class PatientProfileInitial extends PatientProfileState {}

class PatientProfileLoading extends PatientProfileState {}

class PatientProfileLoaded extends PatientProfileState {
  final UserProfileEntity profile;
  final PatientStats stats;
  PatientProfileLoaded(this.profile, {PatientStats? stats})
      : stats = stats ?? const PatientStats();
}

class PatientProfileUpdating extends PatientProfileState {
  final UserProfileEntity profile;
  final PatientStats stats;
  PatientProfileUpdating(this.profile, this.stats);
}

class PatientProfileUpdateSuccess extends PatientProfileState {
  final UserProfileEntity profile;
  final PatientStats stats;
  PatientProfileUpdateSuccess(this.profile, this.stats);
}

class PatientProfileError extends PatientProfileState {
  final String message;
  PatientProfileError(this.message);
}

class PatientStats {
  final int appointmentsCount;
  final int doctorsCount;
  final int recordsCount;

  const PatientStats({
    this.appointmentsCount = 0,
    this.doctorsCount = 0,
    this.recordsCount = 0,
  });
}
