import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatComposer extends StatelessWidget {
  final TextEditingController controller;
  final bool canSend;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  const ChatComposer({
    super.key,
    required this.controller,
    required this.canSend,
    required this.onChanged,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: canSend ? (_) => onSend() : null,
                decoration: const InputDecoration(
                  hintText: 'Ask for post ideas.....',
                ),
              ),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 52.w,
              height: 52.w,
              child: IconButton.filled(
                tooltip: 'Send',
                onPressed: canSend ? onSend : null,
                icon: const Icon(Icons.send_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
