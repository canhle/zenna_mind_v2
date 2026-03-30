import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_template/core/error/failures.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapToFailure(err);
    handler.reject(
      DioException(requestOptions: err.requestOptions, error: failure),
    );
  }

  Failure _mapToFailure(DioException err) {
    // Handle DioExceptionType first (timeout, cancel, no connection)
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutFailure();

      case DioExceptionType.cancel:
        return const CancelledFailure();

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (err.error is SocketException) {
          return const NetworkFailure('No internet connection');
        }
        return NetworkFailure(err.message ?? 'Network error');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificate error');

      case DioExceptionType.badResponse:
        return _mapStatusCode(err);
    }
  }

  Failure _mapStatusCode(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    return switch (statusCode) {
      HttpStatus.badRequest || HttpStatus.unprocessableEntity => BadRequestFailure(
          message: _extractMessage(data) ?? 'Bad request',
          errors: _extractValidationErrors(data),
        ),
      HttpStatus.unauthorized => const UnauthorizedFailure(),
      HttpStatus.forbidden => const ForbiddenFailure(),
      HttpStatus.notFound => const NotFoundFailure(),
      final code? when code >= HttpStatus.internalServerError => ServerFailure(
          message: _extractMessage(data) ?? 'Server error',
          errorCode: _extractErrorCode(data),
        ),
      _ => NetworkFailure(err.message ?? 'Unexpected error'),
    };
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }

  String? _extractErrorCode(dynamic data) {
    if (data is Map<String, dynamic>) return data['errorCode'] as String?;
    return null;
  }

  Map<String, List<String>>? _extractValidationErrors(dynamic data) {
    if (data is! Map<String, dynamic>) return null;
    final errors = data['errors'];
    if (errors is! Map<String, dynamic>) return null;

    return errors.map(
      (key, value) => MapEntry(
        key,
        (value is List) ? value.cast<String>() : [value.toString()],
      ),
    );
  }
}
