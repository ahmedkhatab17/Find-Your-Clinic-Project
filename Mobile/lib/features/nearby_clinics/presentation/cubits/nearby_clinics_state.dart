import '../../../search/domain/entities/doctor_search_entities.dart';

/// Sealed state for NearbyClinics.
sealed class NearbyClinicsState {
  const NearbyClinicsState();
}

class NearbyClinicsInitial extends NearbyClinicsState {}

class NearbyClinicsLoading extends NearbyClinicsState {}

class NearbyClinicsLoaded extends NearbyClinicsState {
  final List<DoctorSearchResult> clinics;
  final double lat;
  final double lng;
  const NearbyClinicsLoaded(this.clinics, this.lat, this.lng);
}

class NearbyClinicsError extends NearbyClinicsState {
  final String message;
  const NearbyClinicsError(this.message);
}
