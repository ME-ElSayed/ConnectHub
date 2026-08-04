import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatMessageRole { user, bot }

class ChatMessage {
  final String? id;
  final String text;
  final ChatMessageRole role;
  final DateTime createdAt;
  final bool isError;

  const ChatMessage({
    this.id,
    required this.text,
    required this.role,
    required this.createdAt,
    this.isError = false,
  });

  bool get isUser => role == ChatMessageRole.user;

  ChatMessage copyWith({
    String? id,
    String? text,
    ChatMessageRole? role,
    DateTime? createdAt,
    bool? isError,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      isError: isError ?? this.isError,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'role': role.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'isError': isError,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map, {String? id}) {
    final rawCreatedAt = map['createdAt'];

    return ChatMessage(
      id: id ?? map['id'] as String?,
      text: map['text'] as String? ?? '',
      role: ChatMessageRole.values.firstWhere(
        (role) => role.name == map['role'],
        orElse: () => ChatMessageRole.bot,
      ),
      createdAt: rawCreatedAt is Timestamp
          ? rawCreatedAt.toDate()
          : DateTime.now(),
      isError: map['isError'] as bool? ?? false,
    );
  }
}
