import 'dart:async';

import 'package:connect_hub/core/network/api_error_handler.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/chat/data/model/chat_message.dart';
import 'package:connect_hub/features/chat/data/repo/chat_repo.dart';
import 'package:connect_hub/features/chat/presentation/cubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required ChatRepo repo,
    required FirestoreService firestoreService,
    required String uid,
  }) : _repo = repo,
       _firestoreService = firestoreService,
       _uid = uid,
       _sessionId = uid,
       super(const ChatState()) {
    assert(uid.isNotEmpty, 'ChatCubit requires a signed-in user uid.');
    unawaited(loadHistory());
  }

  final ChatRepo _repo;
  final FirestoreService _firestoreService;
  final String _uid;
  final String _sessionId;

  Future<void> loadHistory({int limit = 50}) async {
    emit(state.copyWith(isLoadingHistory: true));

    try {
      final history = await _firestoreService.fetchChatHistory(
        _uid,
        _sessionId,
        limit: limit,
      );

      if (isClosed) return;

      final currentMessages = state.messages;

      emit(
        state.copyWith(
          messages: currentMessages.isEmpty
              ? history
              : [...history, ...currentMessages],
          isLoadingHistory: false,
        ),
      );
    } catch (_) {
      if (!isClosed) {
        emit(state.copyWith(isLoadingHistory: false));
      }
    }
  }

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
    _persistMessage(userMessage);

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
      _persistMessage(botMessage);
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

  void _persistMessage(ChatMessage message) {
    if (message.isError) return;

    unawaited(_persistMessageSafely(message));
  }

  Future<void> _persistMessageSafely(ChatMessage message) async {
    try {
      await _firestoreService.saveChatMessage(_uid, _sessionId, message);
    } catch (_) {
      // Firestore persistence is additive and should not interrupt chat.
    }
  }
}
