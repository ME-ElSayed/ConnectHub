import 'package:connect_hub/features/splash/presentation/widgets/animated_splash_loading_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class SplashLoadingDots extends StatefulWidget {
  const SplashLoadingDots({
    super.key,
    this.dotSize = 10,
    this.spacing = 8,
    this.bounceHeight = 6,
    this.duration = const Duration(milliseconds: 900),
    this.colors = const [
      AppColors.whiteOverlay90,
      AppColors.whiteOverlay60,
      AppColors.whiteOverlay40,
    ],
  });

  final double dotSize;
  final double spacing;
  final double bounceHeight;
  final Duration duration;
  final List<Color> colors;

  @override
  State<SplashLoadingDots> createState() => _SplashLoadingDotsState();
}

class _SplashLoadingDotsState extends State<SplashLoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant SplashLoadingDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.dotSize + widget.bounceHeight).r,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var index = 0; index < widget.colors.length; index++) ...[
                AnimatedSplashLoadingDot(
                  animationValue: _controller.value,
                  color: widget.colors[index],
                  index: index,
                  size: widget.dotSize,
                  bounceHeight: widget.bounceHeight,
                ),
                if (index != widget.colors.length - 1)
                  SizedBox(width: widget.spacing.w),
              ],
            ],
          );
        },
      ),
    );
  }
}



