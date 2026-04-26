/// Represents a document to be uploaded during doctor onboarding.
class DoctorDocument {
  final String localPath;
  final String documentType;

  const DoctorDocument({
    required this.localPath,
    required this.documentType,
  });
}

/// Result after documents are submitted.
class UploadedDocument {
  final String documentType;
  final String url;

  const UploadedDocument({required this.documentType, required this.url});
}
