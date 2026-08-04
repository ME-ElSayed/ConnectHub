import 'package:connect_hub/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:connect_hub/features/chat/presentation/cubit/chat_state.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_app_bar.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_composer.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final ValueNotifier<bool> _hasText = ValueNotifier(false);

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _hasText.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _hasText.value = value.trim().isNotEmpty;
  }

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    _controller.clear();
    _hasText.value = false;

    context.read<ChatCubit>().sendMessage(text);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listenWhen: (previous, current) {
        return previous.messages.length != current.messages.length ||
            previous.isSending != current.isSending;
      },
      listener: (context, state) {
        _scrollToBottom();
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const ChatAppBar(),
          body: SafeArea(
            child: Column(
              children: [
                if (state.isLoadingHistory)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                Expanded(
                  child: ChatMessagesList(
                    controller: _scrollController,
                    messages: state.messages,
                    isTyping: state.isSending,
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _hasText,
                  builder: (context, hasText, _) {
                    return ChatComposer(
                      controller: _controller,
                      canSend: hasText && !state.isSending,
                      onChanged: _onChanged,
                      onSend: _send,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
