/// Typed failure classes for error handling across layers.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

/// Server returned an error response (4xx/5xx).
class ServerFailure extends Failure {
  final int? statusCode;
  final List<String>? errors;
  const ServerFailure(super.message, {this.statusCode, this.errors});
}

/// No internet connection or request timed out.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection. Please check your network.']);
}

/// Token expired or invalid — user needs to re-authenticate.
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Session expired. Please login again.']);
}

/// Resource not found (404).
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'The requested resource was not found.']);
}

/// Validation errors from the server or client.
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;
  const ValidationFailure(super.message, {this.fieldErrors});
}

/// Unknown or unexpected error.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong. Please try again.']);
}
