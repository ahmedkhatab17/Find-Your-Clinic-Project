import '../../../../core/network/api_result.dart';
import '../entities/user_profile_entity.dart';
import '../repos/patient_profile_repository.dart';

class GetPatientProfileUseCase {
  final PatientProfileRepository _repo;
  const GetPatientProfileUseCase(this._repo);

  Future<ApiResult<UserProfileEntity>> call() => _repo.getProfile();
}

class GetPatientProfileForDoctorUseCase {
  final PatientProfileRepository _repo;
  const GetPatientProfileForDoctorUseCase(this._repo);

  Future<ApiResult<UserProfileEntity>> call(String patientId) =>
      _repo.getPatientProfileForDoctor(patientId);
}

class UpdatePatientProfileUseCase {
  final PatientProfileRepository _repo;
  const UpdatePatientProfileUseCase(this._repo);

  Future<ApiResult<UserProfileEntity>> call({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
    String? emergencyContactName,
    String? emergencyContactPhone,
  }) =>
      _repo.updateProfile(
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
}
class UpdatePatientProfileImageUseCase {
  final PatientProfileRepository _repo;
  const UpdatePatientProfileImageUseCase(this._repo);

  Future<ApiResult<String>> call(String filePath) =>
      _repo.updateProfileImage(filePath);
}
