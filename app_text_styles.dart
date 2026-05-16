import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.darkOlive,
    height: 1.3,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.darkOlive,
    height: 1.3,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'NotoSansArabic',
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
  );
}
