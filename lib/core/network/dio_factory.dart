import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio != null) {
      return _dio!;
    }

    final dio = Dio(_baseOptions);
    dio.interceptors.add(_headersInterceptor);

    if (kDebugMode) {
      dio.interceptors.add(_loggerInterceptor);
    }

    _dio = dio;
    return dio;
  }

  static void setToken(String token) {
    getDio().options.headers[ApiConstants.authorizationHeader] =
        '${ApiConstants.bearer} $token';
  }

  static void clearToken() {
    getDio().options.headers.remove(ApiConstants.authorizationHeader);
  }

  static void reset() {
    _dio?.close(force: true);
    _dio = null;
  }

  static BaseOptions get _baseOptions {
    return BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      responseType: ResponseType.json,
      headers: const {
        Headers.acceptHeader: ApiConstants.applicationJson,
        Headers.contentTypeHeader: ApiConstants.applicationJson,
      },
    );
  }

  static InterceptorsWrapper get _headersInterceptor {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll({
          Headers.acceptHeader: ApiConstants.applicationJson,
          Headers.contentTypeHeader: ApiConstants.applicationJson,
        });
        handler.next(options);
      },
    );
  }

  static PrettyDioLogger get _loggerInterceptor {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }
}
