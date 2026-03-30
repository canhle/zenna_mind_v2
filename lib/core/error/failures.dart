sealed class Failure implements Exception {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Connection timed out']);
}

class CancelledFailure extends Failure {
  const CancelledFailure([super.message = 'Request cancelled']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Unauthorized');
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure() : super('Forbidden');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super('Not found');
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({
    String message = 'Bad request',
    this.errors,
  }) : super(message);
  final Map<String, List<String>>? errors;
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server error', this.errorCode})
      : super(message);
  final String? errorCode;
}
