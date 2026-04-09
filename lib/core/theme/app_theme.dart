import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColor.primary,
        primary: AppColor.primary,
        surface: AppColor.surface,
        error: AppColor.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.background,
        elevation: 0,
        centerTitle: false,
        foregroundColor: AppColor.textPrimary,
      ),
      cardTheme: const CardThemeData(
        color: AppColor.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      dividerColor: AppColor.border,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.error),
        ),
      ),
    );
  }
}
