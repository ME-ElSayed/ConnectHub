import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/chat/data/model/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isUser = message.isUser;
    final backgroundColor = isUser
        ? colorScheme.primary
        : message.isError
        ? colorScheme.errorContainer
        : colorScheme.surfaceContainerHigh;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 0.78.sw),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.r),
              topRight: Radius.circular(18.r),
              bottomLeft: Radius.circular(isUser ? 18.r : 4.r),
              bottomRight: Radius.circular(isUser ? 4.r : 18.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Text(message.text, style: AppStyles.body14Regular),
          ),
        ),
      ),
    );
  }
}
