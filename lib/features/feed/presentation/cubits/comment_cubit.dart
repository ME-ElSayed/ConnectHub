import 'dart:async';

import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/feed/data/services/comment_service.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_state.dart';
import 'package:connect_hub/features/feed/presentation/cubits/current_user_profile.dart';
import 'package:connect_hub/features/post/data/models/comment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit({
    required CommentService commentService,
    required AuthService authService,
    required FirestoreService firestoreService,
  }) : _commentService = commentService,
       _authService = authService,
       _firestoreService = firestoreService,
       super(const CommentState());

  final CommentService _commentService;
  final AuthService _authService;
  final FirestoreService _firestoreService;

  StreamSubscription<List<CommentModel>>? _commentsSubscription;
  List<CommentModel> _remoteComments = const <CommentModel>[];
  List<CommentModel> _pendingComments = const <CommentModel>[];

  void watchComments(String postId) {
    _commentsSubscription?.cancel();

    if (postId.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CommentStatus.error,
          errorMessage: 'Post id is missing.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(status: CommentStatus.loading, clearErrorMessage: true),
    );

    _commentsSubscription = _commentService
        .watchComments(postId)
        .listen(
          (comments) {
            _remoteComments = comments;
            _emitComments(CommentStatus.loaded);
          },
          onError: (Object error) {
            emit(
              state.copyWith(
                status: CommentStatus.error,
                errorMessage: error.toString(),
              ),
            );
          },
        );
  }

  Future<void> addComment({
    required String postId,
    required String message,
  }) async {
    final trimmedMessage = message.trim();

    if (trimmedMessage.isEmpty) {
      return;
    }

    if (postId.trim().isEmpty) {
      emit(
        state.copyWith(
          status: CommentStatus.error,
          errorMessage: 'Post id is missing.',
        ),
      );
      return;
    }

    late final CurrentUserProfile profile;

    try {
      profile = await CurrentUserProfile.resolve(
        authService: _authService,
        firestoreService: _firestoreService,
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CommentStatus.error,
          errorMessage: error.toString(),
        ),
      );
      return;
    }

    final now = DateTime.now();
    final optimisticComment = CommentModel(
      id: 'local-${now.microsecondsSinceEpoch}',
      userId: profile.userId,
      username: profile.username,
      profileImageUrl: profile.profileImageUrl,
      message: trimmedMessage,
      createdAt: now,
      updatedAt: now,
    );

    _pendingComments = <CommentModel>[..._pendingComments, optimisticComment];
    _emitComments(CommentStatus.adding);

    try {
      final savedId = await _commentService.addComment(
        postId: postId,
        comment: optimisticComment,
      );
      _pendingComments = _pendingComments
          .where((comment) => comment.id != optimisticComment.id)
          .toList();
      _upsertRemoteComment(optimisticComment.copyWith(id: savedId));
      _emitComments(CommentStatus.success);
    } catch (error) {
      _pendingComments = _pendingComments
          .where((comment) => comment.id != optimisticComment.id)
          .toList();
      emit(
        state.copyWith(
          status: CommentStatus.error,
          comments: _mergedComments(),
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _upsertRemoteComment(CommentModel comment) {
    final index = _remoteComments.indexWhere(
      (remoteComment) => remoteComment.id == comment.id,
    );

    if (index == -1) {
      _remoteComments = <CommentModel>[..._remoteComments, comment];
      return;
    }

    final nextComments = [..._remoteComments];
    nextComments[index] = comment;
    _remoteComments = nextComments;
  }

  void _emitComments(CommentStatus status) {
    emit(
      state.copyWith(
        status: status,
        comments: _mergedComments(),
        clearErrorMessage: true,
      ),
    );
  }

  List<CommentModel> _mergedComments() {
    final comments = <CommentModel>[..._remoteComments, ..._pendingComments];

    comments.sort(
      (first, second) => first.createdAt.compareTo(second.createdAt),
    );
    return comments;
  }

  @override
  Future<void> close() async {
    await _commentsSubscription?.cancel();
    return super.close();
  }
}
