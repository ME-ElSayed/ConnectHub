import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  static const String authorizationHeader = 'Authorization';
  static const String bearer = 'Bearer';
  static const String applicationJson = 'application/json';
  static final String n8nChatWebhookUrl =
      (dotenv.env['N8N_CHAT_WEBHOOK_URL'] ?? '').trim();
}
