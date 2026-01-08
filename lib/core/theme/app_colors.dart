import 'package:flutter/material.dart';

class AppColors {
  // Arka plan renkleri
  static const Color background = Color(0xFF000000); // #000000
  static const Color scaffoldBackground = Color(0xFF000000);

  // Neon mor tonları
  static const Color neonPurple = Color(0xFFBC13FE); // Ana neon mor
  static const Color lightNeonPurple = Color(0xFFD06CFF);
  static const Color darkNeonPurple = Color(0xFF9C00D6);

  // Elektrik mavisi tonları
  static const Color electricBlue = Color(0xFF00F0FF); // Ana elektrik mavisi
  static const Color lightElectricBlue = Color(0xFF64F7FF);
  static const Color darkElectricBlue = Color(0xFF00B8C8);

  // Gradient'ler
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.neonPurple,
      AppColors.electricBlue,
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.neonPurple,
      AppColors.lightNeonPurple,
      AppColors.electricBlue,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient vibrantGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.neonPurple,
      AppColors.electricBlue,
      AppColors.lightNeonPurple,
      AppColors.lightElectricBlue,
    ],
    stops: [0.0, 0.33, 0.66, 1.0],
  );

  static const LinearGradient subtleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.darkNeonPurple,
      AppColors.background,
    ],
    stops: [0.0, 1.0],
  );
}