import 'package:connect_hub/features/chat/data/model/chat_message.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_bubble.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({
    super.key,
    required this.controller,
    required this.messages,
    required this.isTyping,
  });

  final ScrollController controller;
  final List<ChatMessage> messages;
  final bool isTyping;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: ListView.separated(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        itemCount: messages.length + (isTyping ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(height: 10.h),
        itemBuilder: (_, index) {
          if (index == messages.length) {
            return const ChatTypingIndicator();
          }
      
          return ChatBubble(message: messages[index]);
        },
      ),
    );
  }
}
