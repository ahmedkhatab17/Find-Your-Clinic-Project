import '../../../../core/network/api_result.dart';
import '../entities/doctor_dashboard_entities.dart';
import '../repos/doctor_dashboard_repository.dart';

class GetDoctorDashboardUseCase {
  final DoctorDashboardRepository _repository;
  const GetDoctorDashboardUseCase(this._repository);

  Future<ApiResult<DoctorDashboard>> call() => _repository.getDashboard();
}
