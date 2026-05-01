sealed class DoctorShellProfileState {}

class DoctorShellProfileInitial extends DoctorShellProfileState {}

class DoctorShellProfileLoading extends DoctorShellProfileState {}

class DoctorShellProfileLoaded extends DoctorShellProfileState {
  final String fullName;
  final String specialty;
  final String? profileImageUrl;
  final double avgRating;
  final int reviewsCount;
  final int totalPatients;
  final int experienceYears;
  final double consultationFee;

  DoctorShellProfileLoaded({
    required this.fullName,
    required this.specialty,
    this.profileImageUrl,
    required this.avgRating,
    required this.reviewsCount,
    required this.totalPatients,
    required this.experienceYears,
    required this.consultationFee,
  });
}

class DoctorShellProfileError extends DoctorShellProfileState {
  final String message;
  DoctorShellProfileError(this.message);
}
