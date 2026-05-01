import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repos/patient_profile_repository.dart';
import '../models/user_profile_model.dart';

class PatientProfileRepositoryImpl implements PatientProfileRepository {
  final ApiClient _apiClient;

  const PatientProfileRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ApiResult<UserProfileEntity>> getProfile() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.userProfile);
      final data = response.data['data'] as Map<String, dynamic>;
      return Success(UserProfileModel.fromJson(data).toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<ApiResult<UserProfileEntity>> getPatientProfileForDoctor(String patientId) async {
    try {
      final response = await _apiClient.dio
          .get(ApiEndpoints.patientProfileForDoctor(patientId));
      final data = response.data['data'] as Map<String, dynamic>;
      return Success(UserProfileModel.fromJson(data).toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final response = await _apiClient.dio.put(
        ApiEndpoints.userProfile,
        data: {
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'dateOfBirth': dateOfBirth?.toIso8601String(),
          'gender': gender,
          'bloodType': bloodType,
          'address': address,
          'emergencyContactName': emergencyContactName,
          'emergencyContactPhone': emergencyContactPhone,
        },
      );
      final data = response.data['data'] as Map<String, dynamic>;
      return Success(UserProfileModel.fromJson(data).toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<ApiResult<String>> updateProfileImage(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _apiClient.dio.put(
        ApiEndpoints.userProfileImage,
        data: formData,
      );

      final imageUrl = response.data['data'] as String;
      return Success(imageUrl);
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
