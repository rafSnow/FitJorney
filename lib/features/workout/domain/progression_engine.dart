import '../domain/set_record.dart';

/// Incrementos de carga baseados em classificação científica.
/// Fonte: Kraemer & Ratamess (2004)
class ProgressionConstants {
  ProgressionConstants._();

  static double getSuggestedIncrement(MuscleSize size, ExerciseType type) {
    return switch ((size, type)) {
      (MuscleSize.large, ExerciseType.compound) => 2.5,
      (MuscleSize.large, ExerciseType.isolation) => 1.25,
      (MuscleSize.small, ExerciseType.compound) => 1.25,
      (MuscleSize.small, ExerciseType.isolation) => 0.5,
    };
  }
}

/// Tamanho do grupo muscular para cálculo de incremento.
enum MuscleSize { large, small }

/// Tipo de exercício para cálculo de incremento.
enum ExerciseType { compound, isolation }

/// Resultado da análise de progressão para um exercício.
class ProgressionResult {
  const ProgressionResult({
    required this.shouldIncreaseLoad,
    required this.shouldDecreaseLoad,
    this.suggestedNewLoad,
    this.message,
  });

  final bool shouldIncreaseLoad;

  /// True quando 2 sessões consecutivas ficaram abaixo do rep_min.
  final bool shouldDecreaseLoad;

  final double? suggestedNewLoad;
  final String? message;

  bool get hasAction => shouldIncreaseLoad || shouldDecreaseLoad;
}

/// Motor de progressão — lógica pura, sem dependência de UI ou banco.
/// 100% testável.
class ProgressionEngine {
  ProgressionEngine._();

  /// Analisa as séries de uma sessão e retorna recomendação de progressão.
  ///
  /// [sets] séries da sessão atual para o exercício (ignoradas as skipped).
  /// [repMin] mínimo do range configurado no programa.
  /// [repMax] máximo do range configurado no programa.
  /// [currentLoad] carga atual do exercício.
  /// [increment] incremento configurado (sobrescreve o padrão se fornecido).
  /// [previousSessionSets] séries da sessão anterior (para detectar regressão).
  static ProgressionResult analyze({
    required List<SetRecord> sets,
    required int repMin,
    required int repMax,
    required double currentLoad,
    required double increment,
    List<SetRecord>? previousSessionSets,
  }) {
    final effectiveSets = sets.where((s) => !s.wasSkipped).toList();

    if (effectiveSets.isEmpty) {
      return const ProgressionResult(
        shouldIncreaseLoad: false,
        shouldDecreaseLoad: false,
      );
    }

    final allAtMax = effectiveSets.every(
      (s) => (s.repsCompleted ?? 0) >= repMax,
    );
    final allBelowMin = effectiveSets.every(
      (s) => (s.repsCompleted ?? 0) < repMin,
    );

    final effectivePrev =
        previousSessionSets?.where((s) => !s.wasSkipped).toList() ?? [];
    final prevAllBelowMin =
        effectivePrev.isNotEmpty &&
        effectivePrev.every((s) => (s.repsCompleted ?? 0) < repMin);

    if (allAtMax) {
      return ProgressionResult(
        shouldIncreaseLoad: true,
        shouldDecreaseLoad: false,
        suggestedNewLoad: currentLoad + increment,
        message:
            'Você atingiu o máximo em todas as séries! Hora de aumentar a carga.',
      );
    }

    if (allBelowMin && prevAllBelowMin) {
      return ProgressionResult(
        shouldIncreaseLoad: false,
        shouldDecreaseLoad: true,
        suggestedNewLoad: (currentLoad - increment).clamp(
          0.0,
          double.maxFinite,
        ),
        message: 'Carga muito alta por 2 sessões. Considere reduzir.',
      );
    }

    return const ProgressionResult(
      shouldIncreaseLoad: false,
      shouldDecreaseLoad: false,
    );
  }
}
