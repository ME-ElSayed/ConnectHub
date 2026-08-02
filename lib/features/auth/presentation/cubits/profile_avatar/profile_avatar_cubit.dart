import 'package:connect_hub/core/services/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_avatar_state.dart';

class ProfileAvatarCubit extends Cubit<ProfileAvatarState> {
  ProfileAvatarCubit({
    String? initialImageUrl,
    required String defaultAssetPath,
  }) : super(
          ProfileAvatarState(
            networkImageUrl: initialImageUrl,
            defaultAssetPath: defaultAssetPath,
          ),
        );

  Future<void> pickImage(BuildContext context) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final file = await ImageService.pickAndCropImage(context);

      if (file != null) {
        emit(state.copyWith(imageFile: file, isLoading: false));
      } else {
        // User cancelled picker/cropper — nothing changed.
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      debugPrint('ProfileAvatarCubit Error: $e');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to select image.',
        ),
      );
    }
  }

  void removeImage() {
    emit(state.copyWith(clearImageFile: true, clearError: true));
  }
}