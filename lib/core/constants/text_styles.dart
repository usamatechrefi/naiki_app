import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  // -----------------------------
  //  FONT FAMILY SHORT NAMES
  // -----------------------------
  static const String inder = 'Inder';
  static const String imprima = 'Imprima';
  static const String indieFlower = 'IndieFlower';

  // -----------------------------
  //  DISPLAY / HEADINGS
  // -----------------------------
  static const TextStyle displayLarge = TextStyle(
    fontFamily: inder,
    fontSize: 48,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: inder,
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: inder,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  // -----------------------------
  //  HEADLINES
  // -----------------------------
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: inder,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: inder,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: inder,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  // -----------------------------
  //  TITLE TEXT (buttons, cards, sections)
  // -----------------------------
  static const TextStyle titleLarge = TextStyle(
    fontFamily: inder,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: inder,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: inder,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textBlack,
  );

  // -----------------------------
  //  BODY TEXT
  // -----------------------------
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: imprima,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: imprima,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: imprima,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // -----------------------------
  //  LABELS (inputs, chips, ui)
  // -----------------------------
  static const TextStyle labelLarge = TextStyle(
    fontFamily: imprima,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: imprima,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: imprima,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  // -----------------------------
  //  SPECIAL DECORATIVE TEXT (Indie)
  // -----------------------------
  static const TextStyle decorative = TextStyle(
    fontFamily: indieFlower,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // -----------------------------
  //  BUTTONS (HIGHLY REUSABLE)
  // -----------------------------
  static  const TextStyle buttonPrimary = TextStyle(
    fontFamily: inder,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontFamily: imprima,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  // -----------------------------
  //  ROLE SELECTION BUTTON TEXT (your current use-case)
  // -----------------------------
  static const TextStyle roleButtonTitle = TextStyle(
    fontFamily: inder,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle roleButtonSubtitle = TextStyle(
    fontFamily: imprima,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
}
