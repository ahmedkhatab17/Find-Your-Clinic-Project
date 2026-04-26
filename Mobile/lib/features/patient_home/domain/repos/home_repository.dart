import '../../../../core/network/api_result.dart';
import '../entities/home_entities.dart';

/// Home repository contract — domain layer.
abstract class HomeRepository {
  Future<ApiResult<HomeSummary>> getHomeSummary();
}
