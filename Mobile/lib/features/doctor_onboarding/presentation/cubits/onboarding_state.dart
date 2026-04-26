import '../../domain/entities/onboarding_entities.dart';

sealed class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingDocumentsUploaded extends OnboardingState {
  final List<UploadedDocument> documents;
  OnboardingDocumentsUploaded(this.documents);
}

class OnboardingError extends OnboardingState {
  final String message;
  OnboardingError(this.message);
}
