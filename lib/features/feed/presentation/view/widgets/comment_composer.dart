import 'package:connect_hub/core/constant/app_constants.dart';
import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/feed/presentation/view/widgets/comment_send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentComposer extends StatelessWidget {
  const CommentComposer({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        10.h,
        16.w,
        10.h,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              maxLength:
                  AppConstants.maxCommentLength,
              textInputAction:
                  TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                hintStyle:
                    AppStyles.body14SecondaryRegular,
                counterText: '',
                filled: true,
                fillColor:
                    AppColors.neutral100,
                contentPadding:
                    EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 10.h,
                ),
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    18.r,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          CommentSendButton(
            controller: controller,
            onSend: onSend,
          ),
        ],
      ),
    );
  }
}