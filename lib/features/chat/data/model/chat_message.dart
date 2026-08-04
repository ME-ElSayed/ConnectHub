enum ChatMessageRole { user, bot }

class ChatMessage {
  final String text;
  final ChatMessageRole role;
  final DateTime createdAt;
  final bool isError;

  const ChatMessage({
    required this.text,
    required this.role,
    required this.createdAt,
    this.isError = false,
  });

  bool get isUser => role == ChatMessageRole.user;
}
