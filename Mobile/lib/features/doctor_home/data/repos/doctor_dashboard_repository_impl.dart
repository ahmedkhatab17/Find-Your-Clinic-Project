import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/failure.dart';
import '../../domain/entities/doctor_dashboard_entities.dart';
import '../../domain/repos/doctor_dashboard_repository.dart';
import '../models/doctor_dashboard_models.dart';

class DoctorDashboardRepositoryImpl implements DoctorDashboardRepository {
  final ApiClient _apiClient;

  const DoctorDashboardRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<ApiResult<DoctorDashboard>> getDashboard() async {
    try {
      final response =
          await _apiClient.dio.get(ApiEndpoints.doctorDashboard);
      final data = response.data['data'] as Map<String, dynamic>;
      final model = DoctorDashboardModel.fromJson(data);
      return Success(model.toEntity());
    } on DioException catch (e) {
      return Error(mapDioException(e));
    } catch (e) {
      return Error(UnknownFailure(e.toString()));
    }
  }
}
