/// Constantes de progressão por classificação de exercício.
///
/// Baseado em Kraemer & Ratamess (2004) — incrementos sugeridos
/// por tipo de exercício e tamanho do grupo muscular.
class ProgressionConstants {
  ProgressionConstants._();

  /// Incremento padrão para exercício composto de músculo grande.
  static const double largeCompound = 2.5;

  /// Incremento padrão para exercício composto de músculo pequeno.
  static const double smallCompound = 1.25;

  /// Incremento padrão para exercício isolado de músculo grande.
  static const double largeIsolation = 1.25;

  /// Incremento padrão para exercício isolado de músculo pequeno.
  static const double smallIsolation = 0.5;

  /// Tempo de descanso padrão em segundos.
  static const int defaultRestSeconds = 90;

  /// Retorna o incremento sugerido com base no tamanho do músculo e tipo de exercício.
  static double getSuggestedIncrement({
    required String muscleSize,
    required String exerciseType,
  }) {
    return switch ((muscleSize, exerciseType)) {
      ('large', 'compound') => largeCompound,
      ('large', 'isolation') => largeIsolation,
      ('small', 'compound') => smallCompound,
      ('small', 'isolation') => smallIsolation,
      _ => largeCompound, // fallback seguro
    };
  }
}
