

import 'package:connect_hub/features/chat/data/model/chat_message.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isSending;
  final String? errorMessage;

  const ChatState({
    this.messages = const [],
    this.isSending = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
