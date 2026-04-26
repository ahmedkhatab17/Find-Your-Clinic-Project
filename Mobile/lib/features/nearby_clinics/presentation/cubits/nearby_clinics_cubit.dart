import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/network/api_result.dart';
import '../../../search/domain/entities/doctor_search_entities.dart';
import '../../../search/domain/usecases/search_doctors_usecase.dart';
import 'nearby_clinics_state.dart';

class NearbyClinicsCubit extends Cubit<NearbyClinicsState> {
  final SearchDoctorsUseCase _searchDoctorsUseCase;

  NearbyClinicsCubit({required SearchDoctorsUseCase searchDoctorsUseCase})
      : _searchDoctorsUseCase = searchDoctorsUseCase,
        super(NearbyClinicsInitial());

  Future<void> loadNearbyClinics() async {
    emit(NearbyClinicsLoading());

    try {
      // Check location permissions.
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(const NearbyClinicsError(
            'Location permission required to find nearby clinics.'));
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      final filters = SearchFilters(
        lat: position.latitude,
        lng: position.longitude,
        radiusKm: 20,
        pageSize: 50,
      );

      final result = await _searchDoctorsUseCase(filters);

      switch (result) {
        case Success(:final data):
          emit(NearbyClinicsLoaded(
              data.items, position.latitude, position.longitude));
        case Error(:final failure):
          emit(NearbyClinicsError(failure.message));
      }
    } catch (e) {
      emit(NearbyClinicsError(e.toString()));
    }
  }
}
