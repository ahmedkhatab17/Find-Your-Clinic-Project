import '../../../../core/network/api_result.dart';
import '../entities/doctor_search_entities.dart';
import '../repos/doctor_search_repository.dart';

class SearchDoctorsUseCase {
  final DoctorSearchRepository _repository;
  const SearchDoctorsUseCase(this._repository);

  Future<ApiResult<PaginatedDoctors>> call(SearchFilters filters) =>
      _repository.searchDoctors(filters);
}
