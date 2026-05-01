import '../../../../core/network/api_result.dart';
import '../entities/user_profile_entity.dart';

abstract interface class PatientProfileRepository {
  Future<ApiResult<UserProfileEntity>> getProfile();
  Future<ApiResult<UserProfileEntity>> getPatientProfileForDoctor(String patientId);
  Future<ApiResult<UserProfileEntity>> updateProfile({
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? bloodType,
    String? address,
    String? emergencyContactName,
    String? emergencyContactPhone,
  });
  Future<ApiResult<String>> updateProfileImage(String filePath);
}
