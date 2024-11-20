import 'package:dio/dio.dart';

import 'app_exception.dart';

class ErrorHandler {
  static String handle(Object? e) {
    if (e is NetworkException) {
      return e.message;
    } else if (e is DioException) {
      return _handleDioError(e);
    } else if (e is ApiException) {
      return 'Error ${e.statusCode}: ${e.message}';
    } else if (e is UnknownException) {
      return e.message;
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  static String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badResponse:
        return 'Error response: ${e.response?.statusCode} ${e.response?.statusMessage}';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.unknown:
        return 'An unexpected error occurred';
      default:
        return 'Dio error occurred';
    }
  }
}
