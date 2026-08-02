import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileAvatarState extends Equatable {
  const ProfileAvatarState({
    this.imageFile,
    this.networkImageUrl,
    required this.defaultAssetPath,
    this.isLoading = false,
    this.errorMessage,
  });

  final File? imageFile;
  final String? networkImageUrl;

  final String defaultAssetPath;
  final bool isLoading;
  final String? errorMessage;
  bool get hasCustomImage => imageFile != null;

  ImageProvider get image {
    if (imageFile != null) return FileImage(imageFile!);
    if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      return NetworkImage(networkImageUrl!);
    }
    return AssetImage(defaultAssetPath);
  }

  ProfileAvatarState copyWith({
    File? imageFile,
    bool clearImageFile = false,
    String? networkImageUrl,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileAvatarState(
      imageFile: clearImageFile ? null : (imageFile ?? this.imageFile),
      networkImageUrl: networkImageUrl ?? this.networkImageUrl,
      defaultAssetPath: defaultAssetPath,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        imageFile,
        networkImageUrl,
        defaultAssetPath,
        isLoading,
        errorMessage,
      ];
}