import 'package:flutter/material.dart';

/// Paleta de cores do FitJourney.
class AppColors {
  AppColors._();

  // Primárias
  static const primary = Color(0xFF1A6B3C);
  static const primaryLight = Color(0xFF4CAF77);
  static const primaryDark = Color(0xFF0D4525);

  // Superfícies
  static const surface = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF121212);
  static const card = Color(0xFFF8F8F8);
  static const cardDark = Color(0xFF1E1E1E);

  // Feedback
  static const success = Color(0xFF2E7D32);
  static const warning = Color(0xFFF57C00);
  static const error = Color(0xFFD32F2F);

  // RPE visual (gradiente de intensidade)
  static const rpe6 = Color(0xFF81C784);
  static const rpe7 = Color(0xFFFFD54F);
  static const rpe8 = Color(0xFFFF8A65);
  static const rpe9 = Color(0xFFEF5350);
  static const rpe10 = Color(0xFFB71C1C);

  /// Retorna a cor correspondente ao RPE informado.
  static Color colorForRpe(int rpe) {
    return switch (rpe) {
      <= 6 => rpe6,
      7 => rpe7,
      8 => rpe8,
      9 => rpe9,
      _ => rpe10,
    };
  }
}
