import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashLoadingDot extends StatelessWidget {
  const SplashLoadingDot({super.key, required this.size, required this.color});

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
