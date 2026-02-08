sealed class ApiResult<T> {
  const ApiResult();
}

class ApiOk<T> extends ApiResult<T> {
  const ApiOk(this.data);
  final T data;
}

class ApiErr<T> extends ApiResult<T> {
  const ApiErr(this.message, {this.code});
  final String message;
  final int? code;
}
