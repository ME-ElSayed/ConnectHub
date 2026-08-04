import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/chat/data/model/chat_message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessage message;

  bool get _isUser => message.isUser;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Align(
      alignment: _isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.8.sw),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: _bubbleColor(colors),
          borderRadius: _borderRadius,
        ),
        child: Text(
          message.text,
          style: AppStyles.body14Regular.copyWith(
            color: _textColor(colors),
            height: 1.5,
          ),
        ),
      ),
    );
  }

  BorderRadius get _borderRadius => BorderRadius.only(
    topLeft: Radius.circular(20.r),
    topRight: Radius.circular(20.r),
    bottomLeft: Radius.circular(_isUser ? 20.r : 6.r),
    bottomRight: Radius.circular(_isUser ? 6.r : 20.r),
  );

  Color _bubbleColor(ColorScheme colors) {
    if (_isUser) {
      return colors.primary;
    }

    if (message.isError) {
      return colors.errorContainer;
    }

    return AppColors.neutral500;
  }

  Color _textColor(ColorScheme colors) {
    if (_isUser) {
      return colors.onPrimary;
    }

    if (message.isError) {
      return colors.onErrorContainer;
    }

    return colors.onSecondaryContainer;
  }
}
