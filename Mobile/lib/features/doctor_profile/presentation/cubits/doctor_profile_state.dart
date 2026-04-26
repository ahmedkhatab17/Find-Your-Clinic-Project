import '../../domain/entities/doctor_profile_entities.dart';

/// Sealed state for DoctorProfileCubit.
sealed class DoctorProfileState {
  const DoctorProfileState();
}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorDetails details;
  final List<DoctorReview> reviews;
  final List<AvailabilitySlot> availability;
  const DoctorProfileLoaded({
    required this.details,
    required this.reviews,
    required this.availability,
  });
}

class DoctorProfileError extends DoctorProfileState {
  final String message;
  const DoctorProfileError(this.message);
}
