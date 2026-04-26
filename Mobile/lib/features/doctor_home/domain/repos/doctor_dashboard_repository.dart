import '../../../../core/network/api_result.dart';
import '../entities/doctor_dashboard_entities.dart';

/// Doctor dashboard repository contract — domain layer.
abstract class DoctorDashboardRepository {
  Future<ApiResult<DoctorDashboard>> getDashboard();
}
