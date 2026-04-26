import '../../../../core/network/api_result.dart';
import '../entities/doctor_search_entities.dart';

/// Doctor search repository contract.
abstract class DoctorSearchRepository {
  Future<ApiResult<PaginatedDoctors>> searchDoctors(SearchFilters filters);
}
