import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/feed/data/services/like_service.dart';
import 'package:connect_hub/features/feed/presentation/cubits/current_user_profile.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_state.dart';
import 'package:connect_hub/features/post/data/models/like_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit({
    required LikeService likeService,
    required AuthService authService,
    required FirestoreService firestoreService,
  }) : _likeService = likeService,
       _authService = authService,
       _firestoreService = firestoreService,
       super(const LikeState());

  final LikeService _likeService;
  final AuthService _authService;
  final FirestoreService _firestoreService;

  Future<void> loadLikeStatus({
    required String postId,
    required int initialLikesCount,
  }) async {
    emit(
      state.copyWith(
        status: LikeStatus.loading,
        likesCount: initialLikesCount,
        clearErrorMessage: true,
      ),
    );

    final user = _authService.currentUser;

    if (user == null) {
      emit(
        state.copyWith(
          status: LikeStatus.loaded,
          isLiked: false,
          likesCount: initialLikesCount,
        ),
      );
      return;
    }

    try {
      final isLiked = await _likeService.isLiked(postId, user.uid);
      emit(
        state.copyWith(
          status: LikeStatus.loaded,
          isLiked: isLiked,
          likesCount: initialLikesCount,
          clearErrorMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: LikeStatus.error,
          likesCount: initialLikesCount,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> toggleLike({required String postId}) async {
    if (postId.trim().isEmpty) {
      emit(
        state.copyWith(
          status: LikeStatus.error,
          errorMessage: 'Post id is missing.',
        ),
      );
      return;
    }

    if (_authService.currentUser == null) {
      emit(
        state.copyWith(
          status: LikeStatus.error,
          errorMessage: 'Please sign in to like posts.',
        ),
      );
      return;
    }

    final previousState = state;
    final nextIsLiked = !state.isLiked;
    final nextLikesCount = _nextLikesCount(
      currentCount: state.likesCount,
      wasLiked: state.isLiked,
    );

    emit(
      state.copyWith(
        status: nextIsLiked ? LikeStatus.liked : LikeStatus.unliked,
        isLiked: nextIsLiked,
        likesCount: nextLikesCount,
        clearErrorMessage: true,
      ),
    );

    try {
      if (nextIsLiked) {
        final profile = await CurrentUserProfile.resolve(
          authService: _authService,
          firestoreService: _firestoreService,
        );
        await _likeService.likePost(
          postId: postId,
          like: LikeModel(
            id: profile.userId,
            userId: profile.userId,
            username: profile.username,
            profileImageUrl: profile.profileImageUrl,
            createdAt: DateTime.now(),
          ),
        );
      } else {
        await _likeService.unlikePost(
          postId: postId,
          currentUserId: _authService.currentUser!.uid,
        );
      }
    } catch (error) {
      emit(
        previousState.copyWith(
          status: LikeStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  int _nextLikesCount({required int currentCount, required bool wasLiked}) {
    if (!wasLiked) {
      return currentCount + 1;
    }

    if (currentCount <= 0) {
      return 0;
    }

    return currentCount - 1;
  }
}
