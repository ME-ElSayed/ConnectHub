class ApiErrorModel {
  const ApiErrorModel({required this.message, this.statusCode, this.errors});

  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    final message = json['message'] ?? json['error'] ?? 'Request failed';
    final errors = json['errors'];

    return ApiErrorModel(
      message: message.toString(),
      statusCode: json['statusCode'] as int?,
      errors: errors is Map<String, dynamic> ? errors : null,
    );
  }

  ApiErrorModel copyWith({
    String? message,
    int? statusCode,
    Map<String, dynamic>? errors,
  }) {
    return ApiErrorModel(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      errors: errors ?? this.errors,
    );
  }
}
