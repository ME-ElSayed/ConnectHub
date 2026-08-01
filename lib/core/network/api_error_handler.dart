import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  ApiErrorHandler._();

  static ApiErrorModel handle(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    return const ApiErrorModel(message: 'Unexpected error occurred');
  }

  static ApiErrorModel _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiErrorModel(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return const ApiErrorModel(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return const ApiErrorModel(message: 'Receive timeout');
      case DioExceptionType.transformTimeout:
        return const ApiErrorModel(message: 'Response transform timeout');
      case DioExceptionType.badCertificate:
        return const ApiErrorModel(message: 'Bad certificate');
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return const ApiErrorModel(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return const ApiErrorModel(message: 'No internet connection');
      case DioExceptionType.unknown:
        return const ApiErrorModel(message: 'Unexpected network error');
    }
  }

  static ApiErrorModel _handleBadResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    if (data is Map<String, dynamic>) {
      return ApiErrorModel.fromJson(data).copyWith(statusCode: statusCode);
    }

    return ApiErrorModel(
      message: response?.statusMessage ?? 'Request failed',
      statusCode: statusCode,
    );
  }
}
