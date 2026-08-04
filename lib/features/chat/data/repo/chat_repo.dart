import 'package:connect_hub/core/network/api_constants.dart';
import 'package:dio/dio.dart';

class ChatRepo {
  final Dio _dio;

  ChatRepo(this._dio);

  Future<String> sendMessage({
    required String message,
    required String sessionId,
  }) async {
    final webhookUrl = ApiConstants.n8nChatWebhookUrl;
    if (webhookUrl.isEmpty) {
      throw StateError('N8N_CHAT_WEBHOOK_URL is not configured.');
    }

    final response = await _dio.post(
      webhookUrl,
      data: {'chatInput': message, 'sessionId': sessionId},
    );

    return _extractBotReply(response.data);
  }

  String _extractBotReply(dynamic data) {
    final reply = _findReply(data);
    if (reply == null || reply.trim().isEmpty) {
      throw const FormatException('The n8n agent returned an empty reply.');
    }
    return reply.trim();
  }

  String? _findReply(dynamic data) {
    if (data is String) return data;

    if (data is List && data.isNotEmpty) {
      for (final item in data) {
        final reply = _findReply(item);
        if (reply != null && reply.trim().isNotEmpty) return reply;
      }
    }

    if (data is Map) {
      const replyKeys = [
        'output',
        'reply',
        'response',
        'answer',
        'message',
        'text',
        'content',
      ];

      for (final key in replyKeys) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) return value;
        if (value is Map || value is List) {
          final reply = _findReply(value);
          if (reply != null && reply.trim().isNotEmpty) return reply;
        }
      }
    }

    return null;
  }
}
