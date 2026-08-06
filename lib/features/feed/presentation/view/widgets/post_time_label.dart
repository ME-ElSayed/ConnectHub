import 'package:connect_hub/core/theme/app_styles.dart';
import 'package:connect_hub/core/utils/time_ago.dart';
import 'package:flutter/material.dart';

class PostTimeLabel extends StatelessWidget {
  const PostTimeLabel({
    super.key,
    required this.createdAt,
  });

  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Text(
      timeAgo(createdAt),
      style: AppStyles.body14SecondaryRegular,
    );
  }
}