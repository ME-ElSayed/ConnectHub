import 'package:connect_hub/core/theme/app_colors.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/chat_input_field.dart';
import 'package:connect_hub/features/chat/presentation/view/widgets/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatComposer extends StatelessWidget {
  const ChatComposer({
    super.key,
    required this.controller,
    required this.canSend,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool canSend;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ChatInputField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: canSend ? (_) => onSend() : null,
            ),
          ),
          SizedBox(width: 12.w),
          SendButton(enabled: canSend, onPressed: onSend),
        ],
      ),
    );
  }
}
