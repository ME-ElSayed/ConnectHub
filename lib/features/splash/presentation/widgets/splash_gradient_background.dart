import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplashGradientBackground extends StatelessWidget {
  const SplashGradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.splashGradient,
          stops: [0, 0.5, 1],
        ),
      ),
      child: SizedBox.expand(child: child),
    );
  }
}
