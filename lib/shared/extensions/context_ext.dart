import 'package:flutter/material.dart';

/// Extensões de conveniência no BuildContext.
extension ContextExt on BuildContext {
  /// Atalho para Theme.of(context).
  ThemeData get theme => Theme.of(this);

  /// Atalho para Theme.of(context).colorScheme.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Atalho para Theme.of(context).textTheme.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Atalho para MediaQuery.sizeOf(context).
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Verifica se o tema atual é dark.
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Mostra uma snackbar com a mensagem.
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Theme.of(this).colorScheme.error : null,
      ),
    );
  }
}
