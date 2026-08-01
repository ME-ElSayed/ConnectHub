import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class SplashLoadingDots extends StatelessWidget {
  const SplashLoadingDots({
    super.key,
    this.dotSize = 10,
    this.spacing = 8,
    this.colors = const [
      AppColors.whiteOverlay90,
      AppColors.whiteOverlay60,
      AppColors.whiteOverlay40,
    ],
  });

  final double dotSize;
  final double spacing;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < colors.length; index++) ...[
          _SplashLoadingDot(size: dotSize, color: colors[index]),
          if (index != colors.length - 1) SizedBox(width: spacing.w),
        ],
      ],
    );
  }
}

class _SplashLoadingDot extends StatelessWidget {
  const _SplashLoadingDot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
