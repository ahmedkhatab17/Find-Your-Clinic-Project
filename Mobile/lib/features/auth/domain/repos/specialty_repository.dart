import '../../../../core/network/api_result.dart';
import '../entities/specialty_entity.dart';

abstract class SpecialtyRepository {
  Future<ApiResult<List<Specialty>>> getActiveSpecialties();
}
