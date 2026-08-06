import 'dart:async';

import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:connect_hub/features/profile/data/repos/profile_repo.dart';
import 'package:connect_hub/features/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required ProfileRepository repository})
    : _repository = repository,
      super(const ProfileState());

  final ProfileRepository _repository;
  StreamSubscription<List<PostModel>>? _postsSubscription;

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final user = await _repository.getCurrentUserDetails();

      _postsSubscription?.cancel();
      _postsSubscription = _repository.watchCurrentUserPosts().listen(
        (posts) {
          emit(
            state.copyWith(
              status: ProfileStatus.loaded,
              user: user,
              posts: posts,
              errorMessage: null,
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              status: ProfileStatus.failure,
              errorMessage: error.toString(),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoggingOut: true));

    try {
      await _repository.logout();
      emit(
        state.copyWith(
          status: ProfileStatus.logoutSuccess,
          isLoggingOut: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.toString(),
          isLoggingOut: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _postsSubscription?.cancel();
    return super.close();
  }
}
