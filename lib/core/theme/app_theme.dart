// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart'; // agar tumne separate typography rakhi hai

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    // Your requirements:
    // primary = green
    // scaffold = white
    // app bar = white
    final scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryGreen,
      onPrimary: AppColors.white,
      secondary: AppColors.primaryGreen,
      onSecondary: AppColors.white,

      surface: AppColors.white, // cards / surfaces
      onSurface: AppColors.black, // text on white
      surfaceContainerHighest: const Color(0xFFF2F2F2),
      outline: AppColors.gray,

      error: AppColors.dangerRed,
      onError: AppColors.white,
    );

    return _buildBaseTheme(scheme);
  }

  static ThemeData dark() {
    // Your requirements:
    // primary? (tumne primary specify nahi kiya, but dark me black + appBar red)
    // scaffold = black
    // app bar = red
    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryGreen, // dark me bhi green CTA rakhna best UX
      onPrimary: AppColors.black,
      secondary: AppColors.primaryGreen,
      onSecondary: AppColors.black,

      surface: AppColors.black,
      onSurface: AppColors.white, // text on black
      surfaceContainerHighest: const Color(0xFF161616),
      outline: AppColors.gray,

      error: AppColors.dangerRed,
      onError: AppColors.white,
    );

    return _buildBaseTheme(scheme).copyWith(
      // AppBar specifically red in dark mode
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.dangerRed,
        foregroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.title.copyWith(color: AppColors.white),
      ),
    );
  }

  static ThemeData _buildBaseTheme(ColorScheme scheme) {
    final textTheme = TextTheme(
      headlineLarge: AppTextStyles.h1.copyWith(color: scheme.onSurface),
      headlineMedium: AppTextStyles.h2.copyWith(color: scheme.onSurface),
      titleLarge: AppTextStyles.title.copyWith(color: scheme.onSurface),
      bodyMedium: AppTextStyles.body.copyWith(color: scheme.onSurface),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: scheme.onSurface.withOpacity(0.75),
      ),
      labelLarge: AppTextStyles.button.copyWith(color: scheme.onPrimary),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,

      scaffoldBackgroundColor: scheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor:
            scheme.surface, // light: white, dark: black (override dark above)
        foregroundColor: scheme.onSurface,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge,
      ),

      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
    );
  }
}
