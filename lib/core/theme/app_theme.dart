import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Tema Material 3 do FitJourney — light e dark.
class AppTheme {
  AppTheme._();

  // ──────────── Seed / Color Scheme ────────────

  static const _primarySeed = AppColors.primary;

  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: _primarySeed,
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    error: AppColors.error,
    surface: AppColors.surface,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: _primarySeed,
    brightness: Brightness.dark,
    primary: AppColors.primaryLight,
    error: AppColors.error,
    surface: AppColors.surfaceDark,
  );

  // ──────────── Card Theme ────────────

  static final _cardTheme = CardThemeData(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
    ),
    margin: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
  );

  // ──────────── Input Decoration ────────────

  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
  );

  // ──────────── ElevatedButton ────────────

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );

  // ──────────── Bottom Nav ────────────

  static const _bottomNavTheme = BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  );

  // ──────────── Floating Action Button ────────────

  static final _fabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.md),
    ),
  );

  // ──────────── Themes públicos ────────────

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: _lightScheme,
    scaffoldBackgroundColor: AppColors.surface,
    cardTheme: _cardTheme,
    inputDecorationTheme: _inputDecorationTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    bottomNavigationBarTheme: _bottomNavTheme,
    floatingActionButtonTheme: _fabTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.surface,
      foregroundColor: _lightScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    dividerTheme: const DividerThemeData(space: 1),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: _darkScheme,
    scaffoldBackgroundColor: AppColors.surfaceDark,
    cardTheme: _cardTheme.copyWith(color: AppColors.cardDark),
    inputDecorationTheme: _inputDecorationTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    bottomNavigationBarTheme: _bottomNavTheme,
    floatingActionButtonTheme: _fabTheme.copyWith(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: _darkScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    dividerTheme: const DividerThemeData(space: 1),
  );
}
