import 'dart:math' as math;

import 'package:connect_hub/features/splash/presentation/widgets/splash_loading_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedSplashLoadingDot extends StatelessWidget {
  
  final double animationValue;
  final Color color;
  final int index;
  final double size;
  final double bounceHeight;

  const AnimatedSplashLoadingDot({super.key, required this.animationValue, required this.color, required this.index, required this.size, required this.bounceHeight});

  @override
  Widget build(BuildContext context) {
    final phase = (animationValue + (index * 0.2)) % 1;
    final progress = (math.sin(phase * 2 * math.pi) + 1) / 2;
    final scale = 0.75 + (progress * 0.25);
    final opacity = 0.55 + (progress * 0.45);

    return Transform.translate(
      offset: Offset(0, -progress * bounceHeight.h),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: SplashLoadingDot(size: size, color: color),
        ),
      ),
    );
  }
}