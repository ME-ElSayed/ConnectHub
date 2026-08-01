class ApiConstants {
  ApiConstants._();

  static const String baseUrl = '';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static const String authorizationHeader = 'Authorization';
  static const String bearer = 'Bearer';
  static const String applicationJson = 'application/json';
}
