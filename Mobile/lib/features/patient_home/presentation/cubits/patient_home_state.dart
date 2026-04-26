import '../../domain/entities/home_entities.dart';

/// Sealed state for PatientHomeCubit.
sealed class PatientHomeState {
  const PatientHomeState();
}

class PatientHomeInitial extends PatientHomeState {}

class PatientHomeLoading extends PatientHomeState {}

class PatientHomeLoaded extends PatientHomeState {
  final HomeSummary summary;
  const PatientHomeLoaded(this.summary);
}

class PatientHomeError extends PatientHomeState {
  final String message;
  const PatientHomeError(this.message);
}
