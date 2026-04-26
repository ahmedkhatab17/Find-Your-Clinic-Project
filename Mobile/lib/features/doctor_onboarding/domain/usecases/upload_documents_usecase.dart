import '../../../../core/network/api_result.dart';
import '../entities/onboarding_entities.dart';
import '../repos/onboarding_repository.dart';

class UploadDocumentsUseCase {
  final OnboardingRepository _repository;
  const UploadDocumentsUseCase(this._repository);

  Future<ApiResult<List<UploadedDocument>>> call({
    required List<DoctorDocument> documents,
    required String pendingToken,
  }) =>
      _repository.uploadDocuments(
        documents: documents,
        pendingToken: pendingToken,
      );
}
