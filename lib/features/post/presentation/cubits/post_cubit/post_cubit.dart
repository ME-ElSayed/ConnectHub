import 'dart:io';

import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/features/post/data/repos/post_repo.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({
    required PostRepository repository,
    required AuthService authService,
  }) : _repository = repository,
       _authService = authService,
       super(const PostState());

  final PostRepository _repository;
  final AuthService _authService;

  Future<void> createPost({
    required String title,
    required String content,
    File? image,
  }) async {
    final user = _authService.currentUser;

    if (user == null) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Please sign in to create a post.',
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

    try {
      await _repository.addPost(
        userId: user.uid,
        title: title,
        content: content,
        image: image,
      );

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  void reset() {
    emit(const PostState());
  }
}
