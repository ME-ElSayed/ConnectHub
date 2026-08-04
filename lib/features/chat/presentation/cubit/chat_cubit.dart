import 'dart:math';

import 'package:connect_hub/core/network/api_error_handler.dart';
import 'package:connect_hub/features/chat/data/model/chat_message.dart';
import 'package:connect_hub/features/chat/data/repo/chat_repo.dart';
import 'package:connect_hub/features/chat/presentation/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo _repo;
  late final String _sessionId =
      'heart-check-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(999999)}';

  ChatCubit(this._repo) : super(ChatState());

  Future<void> sendMessage(String rawMessage) async {
    final message = rawMessage.trim();
    if (message.isEmpty || state.isSending) return;

    final userMessage = ChatMessage(
      text: message,
      role: ChatMessageRole.user,
      createdAt: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isSending: true,
        clearError: true,
      ),
    );

    try {
      final reply = await _repo.sendMessage(
        message: message,
        sessionId: _sessionId,
      );

      final botMessage = ChatMessage(
        text: reply,
        role: ChatMessageRole.bot,
        createdAt: DateTime.now(),
      );

      emit(
        state.copyWith(
          messages: [...state.messages, botMessage],
          isSending: false,
        ),
      );
    } catch (error) {
      final errorMessage = _friendlyErrorMessage(error);
      final botMessage = ChatMessage(
        text: errorMessage,
        role: ChatMessageRole.bot,
        createdAt: DateTime.now(),
        isError: true,
      );

      emit(
        state.copyWith(
          messages: [...state.messages, botMessage],
          isSending: false,
          errorMessage: errorMessage,
        ),
      );
    }
  }

  String _friendlyErrorMessage(Object error) {
    if (error is StateError) return error.message;
    if (error is FormatException) return error.message;
    return ApiErrorHandler.handle(error).message;
  }
}
