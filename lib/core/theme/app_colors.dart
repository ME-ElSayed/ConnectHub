import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF2B7FFF);
  static const Color primaryDark = Color(0xFF1B50A7);
  static const Color primaryMid = Color(0xFF226BDE);
  static const Color primaryLight = Color(0xFF58A0F9);
  static const Color primaryForeground = Color(0xFFEFF6FF);

  // Primary overlays used for selected cards, rings, borders, and shadows.
  static const Color primaryOverlay5 = Color(0x0D2B7FFF);
  static const Color primaryOverlay10 = Color(0x1A2B7FFF);
  static const Color primaryOverlay20 = Color(0x332B7FFF);
  static const Color primaryOverlay25 = Color(0x402B7FFF);
  static const Color primaryOverlay30 = Color(0x4D2B7FFF);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color neutral950 = Color(0xFF09090B);
  static const Color neutral500 = Color(0xFF71717B);
  static const Color neutral200 = Color(0xFFE4E4E7);
  static const Color neutral100 = Color(0xFFF4F4F5);

  // Semantic aliases from the Figma design.
  static const Color background = white;
  static const Color surface = white;
  static const Color mutedSurface = neutral100;
  static const Color border = neutral200;
  static const Color textPrimary = neutral950;
  static const Color textSecondary = neutral500;
  static const Color textOnPrimary = primaryForeground;

  // White overlays used on the splash screen.
  static const Color whiteOverlay95 = Color(0xF2FFFFFF);
  static const Color whiteOverlay90 = Color(0xE6FFFFFF);
  static const Color whiteOverlay80 = Color(0xCCFFFFFF);
  static const Color whiteOverlay60 = Color(0x99FFFFFF);
  static const Color whiteOverlay40 = Color(0x66FFFFFF);

  // Effects
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadow = Color(0x1A000000);
  static const Color shadowStrong = Color(0x4D000000);
  static const Color imageScrim = Color(0x66000000);

  static const List<Color> splashGradient = <Color>[
    primaryDark,
    primaryMid,
    primaryLight,
  ];
}
