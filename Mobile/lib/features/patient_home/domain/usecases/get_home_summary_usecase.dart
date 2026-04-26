import '../../../../core/network/api_result.dart';
import '../entities/home_entities.dart';
import '../repos/home_repository.dart';

class GetHomeSummaryUseCase {
  final HomeRepository _repository;
  const GetHomeSummaryUseCase(this._repository);

  Future<ApiResult<HomeSummary>> call() => _repository.getHomeSummary();
}
