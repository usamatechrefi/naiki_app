import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF1DB591); // Teal/Emerald
  static const Color primaryDark = Color(0xFF159B7A);
  static const Color primaryLight = Color(0xFF4DD4B3);

  // Recipient/Female-focused Colors
  static const Color recipient = Color(0xFFFF6B9D); // Rose/Pink
  static const Color recipientLight = Color(0xFFFFE5EE);
  static const Color recipientSoft = Color(0xFFFFF0F5);

  // Donor Colors
  static const Color donor = Color(0xFF34A853); // Green
  static const Color donorLight = Color(0xFFE8F5E9);

  // Registration & Auth Colors (Green Theme - Donor)
  static const Color authDarkGreen = Color(0xFF3D5A3D); // Dark forest green
  static const Color authMediumGreen = Color(0xFF4A6B4A); // Medium green
  static const Color authSageGreen = Color(0xFFB8C4B0); // Sage green card
  static const Color authLightSage = Color(0xFF9CA896); // Light sage

  // Registration & Auth Colors (Pink Theme - Recipient)
  static const Color authRecipientBg = Color(0xFF3D5A3D); // Dark green background
  static const Color authRecipientCard = Color(0xFFB8C4B0); // Sage green card
  static const Color authRecipientInput = Color(0xFF4A6B4A); // Dark green input

  // Gradient for Registration/Auth Screens
  static const List<Color> authGradient = [
    Color(0xFF3D5A3D),
    Color(0xFF4A6B4A),
  ];

  // Welcome Screen Gradient
  static const List<Color> welcomeGradient = [
    Color(0xFF9CA896),
    Color(0xFFB8BDB0),
  ];

  // Neutral Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // NEW — Pure Black Text Color
  static const Color textBlack = Color(0xFF000000);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textOnWhite = Color(0xFFFFFFFF); // White text


  // NEW COLORS YOU REQUESTED
  static const Color backgroundDarkLeaf = Color(0xFF2F4517);
  static const Color backgroundLightOlive = Color(0xFFA5B890); // original
  static const Color backgroundLightOliveLighter = Color(0xFFB8C7A3); // lighter variant
  static const Color backgroundLightOliveLightest = Color(0xFFD0E0BC); // very light variant


  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF1DB591),
    Color(0xFF159B7A),
  ];

  static const List<Color> recipientGradient = [
    Color(0xFFFF6B9D),
    Color(0xFFFF8FB3),
    Color(0xFFFFC2D9),
  ];

  // Onboarding Gradients
  static const List<Color> onboarding1Gradient = [
    Color(0xFFFFE5EE),
    Color(0xFFFFF0F5),
  ];

  static const List<Color> onboarding2Gradient = [
    Color(0xFFE0F7FA),
    Color(0xFFE8F5F0),
  ];

  static const List<Color> onboarding3Gradient = [
    Color(0xFFF0F9FF),
    Color(0xFFE8F5E9),
  ];
}
