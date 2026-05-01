import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../../appointments/domain/usecases/appointment_usecases.dart';
import '../../../health_records/domain/usecases/health_record_usecases.dart';
import '../../domain/usecases/patient_profile_usecases.dart';
import 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  final GetPatientProfileUseCase _getProfile;
  final UpdatePatientProfileUseCase _updateProfile;
  final UpdatePatientProfileImageUseCase _updateProfileImage;
  final GetPatientAppointmentsUseCase _getAppointments;
  final GetHealthSummaryUseCase _getHealthSummary;

  PatientProfileCubit({
    required GetPatientProfileUseCase getProfile,
    required UpdatePatientProfileUseCase updateProfile,
    required UpdatePatientProfileImageUseCase updateProfileImage,
    required GetPatientAppointmentsUseCase getAppointments,
    required GetHealthSummaryUseCase getHealthSummary,
  })  : _getProfile = getProfile,
        _updateProfile = updateProfile,
        _updateProfileImage = updateProfileImage,
        _getAppointments = getAppointments,
        _getHealthSummary = getHealthSummary,
        super(PatientProfileInitial());

  Future<void> loadProfile() async {
    emit(PatientProfileLoading());

    final results = await Future.wait([
      _getProfile(),
      _getAppointments(),
      _getHealthSummary(),
    ]);

    final profileResult = results[0];
    if (profileResult is Error) {
      emit(PatientProfileError((profileResult as Error).failure.message));
      return;
    }
    final profile = (profileResult as Success).data;

    int appointmentsCount = 0;
    int doctorsCount = 0;
    int recordsCount = 0;

    final apptResult = results[1];
    if (apptResult is Success) {
      final apts = (apptResult as Success).data;
      appointmentsCount = (apts as List).length;
      doctorsCount = (apts).map((a) => a.doctorProfileId).toSet().length;
    }

    final summaryResult = results[2];
    if (summaryResult is Success) {
      recordsCount = (summaryResult as Success).data.totalRecords;
    }

    emit(PatientProfileLoaded(
      profile,
      stats: PatientStats(
        appointmentsCount: appointmentsCount,
        doctorsCount: doctorsCount,
        recordsCount: recordsCount,
      ),
    ));
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? imagePath,
  }) async {
    final current = state;
    if (current is! PatientProfileLoaded) return;
    emit(PatientProfileUpdating(current.profile, current.stats));

    String? newImageUrl;
    if (imagePath != null) {
      final imgResult = await _updateProfileImage(imagePath);
      if (imgResult is Success) {
        newImageUrl = (imgResult as Success).data;
      } else {
        emit(PatientProfileLoaded(current.profile, stats: current.stats));
        emit(PatientProfileError((imgResult as Error).failure.message));
        return;
      }
    }

    final result = await _updateProfile(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      gender: gender,
      bloodType: bloodType,
      address: address,
      emergencyContactName: emergencyContactName,
      emergencyContactPhone: emergencyContactPhone,
    );

    switch (result) {
      case Success(:final data):
        var profile = data;
        if (newImageUrl != null) {
          profile = profile.copyWith(profileImageUrl: newImageUrl);
        }
        emit(PatientProfileUpdateSuccess(profile, current.stats));
        emit(PatientProfileLoaded(profile, stats: current.stats));
      case Error(:final failure):
        emit(PatientProfileLoaded(current.profile, stats: current.stats));
        emit(PatientProfileError(failure.message));
    }
  }

  Future<void> updateProfileImage(String filePath) async {
    final current = state;
    if (current is! PatientProfileLoaded) return;

    emit(PatientProfileUpdating(current.profile, current.stats));
    final result = await _updateProfileImage(filePath);

    switch (result) {
      case Success(:final data):
        // data is the new image URL
        final updatedProfile = current.profile.copyWith(profileImageUrl: data);
        emit(PatientProfileUpdateSuccess(updatedProfile, current.stats));
        emit(PatientProfileLoaded(updatedProfile, stats: current.stats));
      case Error(:final failure):
        emit(PatientProfileLoaded(current.profile, stats: current.stats));
        emit(PatientProfileError(failure.message));
    }
  }
}
