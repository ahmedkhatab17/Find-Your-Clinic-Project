import '../../../../core/network/api_result.dart';
import '../entities/onboarding_entities.dart';

/// Onboarding repository contract — domain layer, zero Flutter imports.
abstract class OnboardingRepository {
  /// Upload documents using the pending doctor JWT token.
  Future<ApiResult<List<UploadedDocument>>> uploadDocuments({
    required List<DoctorDocument> documents,
    required String pendingToken,
  });
}
