import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/repos/home_repository.dart';
import '../models/home_models.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient _apiClient;

  const HomeRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ApiResult<HomeSummary>> getHomeSummary() async {
    try {
      final response = await _apiClient.dio.get(ApiEndpoints.homeSummary);
      final data = response.data['data'] as Map<String, dynamic>;
      final model = HomeSummaryModel.fromJson(data);
      return Success(model.toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
