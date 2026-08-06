import 'dart:async';

import 'package:connect_hub/features/feed/data/services/like_service.dart';
import 'package:connect_hub/features/feed/presentation/cubits/likes_state.dart';
import 'package:connect_hub/features/post/data/models/like_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikesViewModel extends Cubit<LikesState> {
  LikesViewModel({required LikeService likeService})
    : _likeService = likeService,
      super(const LikesState());

  final LikeService _likeService;

  StreamSubscription<List<LikeModel>>? _likesSubscription;

  void watchLikes(String postId) {
    _likesSubscription?.cancel();

    if (postId.trim().isEmpty) {
      emit(
        state.copyWith(
          status: LikesStatus.error,
          errorMessage: 'Post id is missing.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: LikesStatus.loading, clearErrorMessage: true));

    _likesSubscription = _likeService
        .watchLikes(postId)
        .listen(
          (likes) {
            emit(
              state.copyWith(
                status: LikesStatus.loaded,
                likes: likes,
                clearErrorMessage: true,
              ),
            );
          },
          onError: (Object error) {
            emit(
              state.copyWith(
                status: LikesStatus.error,
                errorMessage: error.toString(),
              ),
            );
          },
        );
  }

  @override
  Future<void> close() async {
    await _likesSubscription?.cancel();
    return super.close();
  }
}
