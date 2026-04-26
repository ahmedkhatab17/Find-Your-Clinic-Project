import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/doctor_search_entities.dart';
import '../../domain/repos/doctor_search_repository.dart';
import '../models/doctor_search_models.dart';

class DoctorSearchRepositoryImpl implements DoctorSearchRepository {
  final ApiClient _apiClient;

  const DoctorSearchRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ApiResult<PaginatedDoctors>> searchDoctors(
      SearchFilters filters) async {
    try {
      final response = await _apiClient.dio.get(
        ApiEndpoints.doctors,
        queryParameters: filters.toQueryParameters(),
      );
      final data = response.data['data'] as Map<String, dynamic>;
      final model = PaginatedDoctorsModel.fromJson(data);
      return Success(model.toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
