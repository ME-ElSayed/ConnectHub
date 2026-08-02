import 'dart:io';

import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/utils/app_assets.dart';
import 'package:connect_hub/features/auth/presentation/cubits/profile_avatar/profile_avatar_cubit.dart';
import 'package:connect_hub/features/auth/presentation/cubits/profile_avatar/profile_avatar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.networkImageUrl,
    this.defaultAssetPath = AppAssets.avatar,
    this.icon = Icons.camera_alt,
    this.showRemoveButton = true,
    this.onImageChanged,
  });

  final String? networkImageUrl;
  final String defaultAssetPath;
  final IconData? icon;
  final bool showRemoveButton;
  final ValueChanged<File?>? onImageChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileAvatarCubit(
        initialImageUrl: networkImageUrl,
        defaultAssetPath: defaultAssetPath,
      ),
      child: _ProfileAvatarView(
        icon: icon,
        showRemoveButton: showRemoveButton,
        onImageChanged: onImageChanged,
      ),
    );
  }
}

class _ProfileAvatarView extends StatelessWidget {
  const _ProfileAvatarView({
    required this.icon,
    required this.showRemoveButton,
    required this.onImageChanged,
  });

  final IconData? icon;
  final bool showRemoveButton;
  final ValueChanged<File?>? onImageChanged;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileAvatarCubit, ProfileAvatarState>(
      listenWhen: (prev, curr) => prev.imageFile != curr.imageFile,
      listener: (context, state) => onImageChanged?.call(state.imageFile),
      child: BlocBuilder<ProfileAvatarCubit, ProfileAvatarState>(
        builder: (context, state) {
          final cubit = context.read<ProfileAvatarCubit>();

          return Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 60.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: state.image,
              ),

              if (icon != null)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: state.isLoading
                        ? null
                        : () => cubit.pickImage(context),
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: state.isLoading
                          ? SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Icon(icon, color: Colors.white, size: 22.sp),
                    ),
                  ),
                ),

              if (state.hasCustomImage &&
                  showRemoveButton &&
                  !state.isLoading)
                Positioned(
                  top: -2,
                  right: -2,
                  child: InkWell(
                    onTap: cubit.removeImage,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 14.sp, color: Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}