sealed class ApiResult<T> {}

class Success<T> extends ApiResult<T> {
  final T result;
  Success(this.result);
}

class Failure<T> extends ApiResult<T> {
  final T error;
  Failure(this.error);
}

class IsLoading<T> extends ApiResult<T> {
  final String message;
  IsLoading(this.message);
}