import '../../../../core/network/api_result.dart';
import '../entities/doctor_profile_entities.dart';
import '../repos/doctor_profile_repository.dart';

class GetDoctorDetailsUseCase {
  final DoctorProfileRepository _repository;
  const GetDoctorDetailsUseCase(this._repository);

  Future<ApiResult<DoctorDetails>> call(String doctorId) =>
      _repository.getDoctorDetails(doctorId);
}

class GetDoctorReviewsUseCase {
  final DoctorProfileRepository _repository;
  const GetDoctorReviewsUseCase(this._repository);

  Future<ApiResult<List<DoctorReview>>> call(String doctorId) =>
      _repository.getDoctorReviews(doctorId);
}

class GetDoctorAvailabilityUseCase {
  final DoctorProfileRepository _repository;
  const GetDoctorAvailabilityUseCase(this._repository);

  Future<ApiResult<List<AvailabilitySlot>>> call(String doctorId) =>
      _repository.getDoctorAvailability(doctorId);
}
