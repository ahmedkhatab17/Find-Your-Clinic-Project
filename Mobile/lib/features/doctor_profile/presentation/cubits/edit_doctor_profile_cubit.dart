import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../domain/entities/doctor_profile_entities.dart';
import '../../domain/usecases/doctor_profile_usecases.dart';
import 'edit_doctor_profile_state.dart';

class EditDoctorProfileCubit extends Cubit<EditDoctorProfileState> {
  final GetDoctorDetailsUseCase _getDetails;
  final UpdateDoctorProfileUseCase _updateProfile;
  final UpdateDoctorProfileImageUseCase _updateProfileImage;

  EditDoctorProfileCubit({
    required GetDoctorDetailsUseCase getDetails,
    required UpdateDoctorProfileUseCase updateProfile,
    required UpdateDoctorProfileImageUseCase updateProfileImage,
  })  : _getDetails = getDetails,
        _updateProfile = updateProfile,
        _updateProfileImage = updateProfileImage,
        super(EditDoctorProfileInitial());

  Future<void> loadProfile(String doctorUserId) async {
    emit(EditDoctorProfileLoading());
    final result = await _getDetails(doctorUserId);
    switch (result) {
      case Success(:final data):
        emit(EditDoctorProfileLoaded(data));
      case Error(:final failure):
        emit(EditDoctorProfileError(failure.message));
    }
  }

  Future<void> saveProfile(UpdateDoctorProfileParams params, {String? imagePath}) async {
    final current = state;
    if (current is! EditDoctorProfileLoaded) return;
    emit(EditDoctorProfileSaving(current.details));

    String? newImageUrl;
    if (imagePath != null) {
      final imgResult = await _updateProfileImage(imagePath);
      if (imgResult is Success) {
        newImageUrl = (imgResult as Success).data;
      } else {
        emit(EditDoctorProfileLoaded(current.details));
        emit(EditDoctorProfileError((imgResult as Error).failure.message));
        return;
      }
    }

    final result = await _updateProfile(params);
    switch (result) {
      case Success():
        var details = current.details;
        if (newImageUrl != null) {
          details = details.copyWith(profileImageUrl: newImageUrl);
        }
        emit(EditDoctorProfileSaved());
        // We might want to emit Loaded again with the new details if we don't pop the screen
        emit(EditDoctorProfileLoaded(details));
      case Error(:final failure):
        emit(EditDoctorProfileLoaded(current.details));
        emit(EditDoctorProfileError(failure.message));
    }
  }

  Future<void> updateProfileImage(String filePath) async {
    final current = state;
    if (current is! EditDoctorProfileLoaded) return;

    emit(EditDoctorProfileSaving(current.details));
    final result = await _updateProfileImage(filePath);

    switch (result) {
      case Success(:final data):
        // data is the new image URL
        final updatedDetails = current.details.copyWith(profileImageUrl: data);
        emit(EditDoctorProfileLoaded(updatedDetails));
      case Error(:final failure):
        emit(EditDoctorProfileLoaded(current.details));
        emit(EditDoctorProfileError(failure.message));
    }
  }
}
