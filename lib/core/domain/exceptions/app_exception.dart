import 'dart:developer';

abstract class AppException {
  final String message;
  final StackTrace stackTrace;
  final Object exception;

  AppException({
    this.message = 'Something went wrong',
    this.stackTrace = StackTrace.empty,
    this.exception = Null,
  }) {
    log(
      message,
      error: exception,
      stackTrace: stackTrace,
    );
  }
}

