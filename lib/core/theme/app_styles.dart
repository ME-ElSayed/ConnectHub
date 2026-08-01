import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'font_weight_helper.dart';

class AppStyles {
  AppStyles._();

  static TextTheme get textTheme => TextTheme(
    displayLarge: display36Regular,
    headlineSmall: title20SemiBold,
    titleLarge: title18SemiBold,
    titleMedium: title16SemiBold,
    bodyLarge: body16Regular,
    bodyMedium: body14Regular,
    bodySmall: body12Regular,
    labelLarge: label14SemiBold,
    labelMedium: label12Medium,
    labelSmall: label11Regular,
  );

  static TextStyle get display36Regular => _inter(
    fontSize: 36,
    lineHeight: 40,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get display36WhiteRegular =>
      display36Regular.copyWith(color: AppColors.white);

  static TextStyle get title20SemiBold => _inter(
    fontSize: 20,
    lineHeight: 28,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get title20Regular => _inter(
    fontSize: 20,
    lineHeight: 28,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get title18SemiBold => _inter(
    fontSize: 18,
    lineHeight: 28,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get title18Regular => _inter(
    fontSize: 18,
    lineHeight: 28,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get title16SemiBold => _inter(
    fontSize: 16,
    lineHeight: 22,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get body16Regular => _inter(
    fontSize: 16,
    lineHeight: 24,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get body16SecondaryRegular =>
      body16Regular.copyWith(color: AppColors.textSecondary);

  static TextStyle get body14Regular => _inter(
    fontSize: 14,
    lineHeight: 20,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get body14SecondaryRegular =>
      body14Regular.copyWith(color: AppColors.textSecondary);

  static TextStyle get body12Regular => _inter(
    fontSize: 12,
    lineHeight: 16,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get body12SecondaryRegular =>
      body12Regular.copyWith(color: AppColors.textSecondary);

  static TextStyle get label14SemiBold => _inter(
    fontSize: 14,
    lineHeight: 20,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle get label14PrimarySemiBold =>
      label14SemiBold.copyWith(color: AppColors.primary);

  static TextStyle get label14OnPrimarySemiBold =>
      label14SemiBold.copyWith(color: AppColors.textOnPrimary);

  static TextStyle get label12Medium =>
      _inter(fontSize: 12, lineHeight: 16, fontWeight: FontWeightHelper.medium);

  static TextStyle get label12PrimaryMedium =>
      label12Medium.copyWith(color: AppColors.primary);

  static TextStyle get label11Regular => _inter(
    fontSize: 11.sp,
    lineHeight: 24.h,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle get label11PrimaryRegular =>
      label11Regular.copyWith(color: AppColors.primary);

  static TextStyle get label11SecondaryRegular =>
      label11Regular.copyWith(color: AppColors.textSecondary);

  static TextStyle _inter({
    required double fontSize,
    required double lineHeight,
    required FontWeight fontWeight,
    Color color = AppColors.textPrimary,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      height: lineHeight / fontSize,
      letterSpacing: 0,
    );
  }
}
