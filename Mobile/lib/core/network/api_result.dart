import 'failure.dart';

/// Result type for use cases and repositories.
/// Data layer catches exceptions and returns [ApiResult].
/// Presentation layer pattern-matches on the result.
sealed class ApiResult<T> {
  const ApiResult();
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends ApiResult<T> {
  final Failure failure;
  const Error(this.failure);
}
