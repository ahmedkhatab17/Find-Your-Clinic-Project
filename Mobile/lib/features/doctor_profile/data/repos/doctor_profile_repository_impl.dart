import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/doctor_profile_entities.dart';
import '../../domain/repos/doctor_profile_repository.dart';
import '../models/doctor_profile_models.dart';

class DoctorProfileRepositoryImpl implements DoctorProfileRepository {
  final ApiClient _apiClient;

  const DoctorProfileRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ApiResult<DoctorDetails>> getDoctorDetails(String doctorId) async {
    try {
      final response =
          await _apiClient.dio.get(ApiEndpoints.doctorDetails(doctorId));
      final data = response.data['data'] as Map<String, dynamic>;
      return Success(DoctorDetailsModel.fromJson(data).toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<DoctorReview>>> getDoctorReviews(
      String doctorId) async {
    try {
      final response =
          await _apiClient.dio.get(ApiEndpoints.doctorReviews(doctorId));
      final data = response.data['data'] as List;
      final reviews =
          data.map((e) => DoctorReviewModel.fromJson(e).toEntity()).toList();
      return Success(reviews);
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<AvailabilitySlot>>> getDoctorAvailability(
      String doctorId) async {
    try {
      final response =
          await _apiClient.dio.get(ApiEndpoints.doctorAvailability(doctorId));
      final data = response.data['data'] as List;
      final slots = data
          .map((e) => AvailabilitySlotModel.fromJson(e).toEntity())
          .toList();
      return Success(slots);
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
