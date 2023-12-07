sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success({required this.data});

  final T data;
}

class Failure<T> extends Result<T> {
  const Failure({required this.exception});

  final Exception exception;
}
