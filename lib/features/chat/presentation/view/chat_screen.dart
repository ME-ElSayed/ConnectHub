import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:connect_hub/features/chat/presentation/cubit/chat_state.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_bubble.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_composer.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _hasText = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onMessageChanged(String value) {
    final hasText = value.trim().isNotEmpty;
    if (hasText == _hasText) return;

    setState(() {
      _hasText = hasText;
    });
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.trim().isEmpty) return;

    _messageController.clear();
    _onMessageChanged('');
    context.read<ChatCubit>().sendMessage(message);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) => _scrollToBottom(),
      builder: (context, state) {
        final canSend = _hasText && !state.isSending;

        return Scaffold(
          appBar: AppBar(
            title: Text('Post Assistant', style: AppStyles.title20Regular),
            actions: const [],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                    itemCount:
                        state.messages.length + (state.isSending ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      if (index == state.messages.length) {
                        return const ChatTypingIndicator();
                      }

                      return ChatBubble(message: state.messages[index]);
                    },
                  ),
                ),
                ChatComposer(
                  controller: _messageController,
                  canSend: canSend,
                  onChanged: _onMessageChanged,
                  onSend: _sendMessage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
