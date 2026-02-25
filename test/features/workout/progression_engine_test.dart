import 'package:fitjourney/features/workout/domain/progression_engine.dart';
import 'package:fitjourney/features/workout/domain/set_record.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper para criar SetRecord de teste.
SetRecord _makeSet({
  int id = 1,
  int sessionId = 1,
  int programExerciseId = 1,
  int setNumber = 1,
  double? loadKg = 50,
  int? repsCompleted = 10,
  int? rpeAchieved,
  bool isExtra = false,
  bool wasSkipped = false,
}) {
  return SetRecord(
    id: id,
    sessionId: sessionId,
    programExerciseId: programExerciseId,
    setNumber: setNumber,
    loadKg: loadKg,
    repsCompleted: repsCompleted,
    rpeAchieved: rpeAchieved,
    recordedAt: DateTime(2026, 1, 1),
    isExtra: isExtra,
    wasSkipped: wasSkipped,
  );
}

void main() {
  group('ProgressionConstants', () {
    test('composto + grande → 2.5 kg', () {
      expect(
        ProgressionConstants.getSuggestedIncrement(
          MuscleSize.large,
          ExerciseType.compound,
        ),
        2.5,
      );
    });

    test('composto + pequeno → 1.25 kg', () {
      expect(
        ProgressionConstants.getSuggestedIncrement(
          MuscleSize.small,
          ExerciseType.compound,
        ),
        1.25,
      );
    });

    test('isolado + grande → 1.25 kg', () {
      expect(
        ProgressionConstants.getSuggestedIncrement(
          MuscleSize.large,
          ExerciseType.isolation,
        ),
        1.25,
      );
    });

    test('isolado + pequeno → 0.5 kg', () {
      expect(
        ProgressionConstants.getSuggestedIncrement(
          MuscleSize.small,
          ExerciseType.isolation,
        ),
        0.5,
      );
    });
  });

  group('ProgressionEngine.analyze', () {
    // ── Caso 1: Todas as séries no rep_max → deve aumentar carga ──
    test('todas as séries no rep_max → shouldIncreaseLoad = true', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: 12),
        _makeSet(setNumber: 2, repsCompleted: 12),
        _makeSet(setNumber: 3, repsCompleted: 12),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      expect(result.shouldIncreaseLoad, isTrue);
      expect(result.shouldDecreaseLoad, isFalse);
      expect(result.suggestedNewLoad, 52.5);
      expect(result.message, isNotNull);
    });

    // ── Caso 2: Todas as séries ACIMA do rep_max → deve aumentar carga ──
    test('todas as séries acima do rep_max → shouldIncreaseLoad = true', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: 14),
        _makeSet(setNumber: 2, repsCompleted: 13),
        _makeSet(setNumber: 3, repsCompleted: 15),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 40,
        increment: 1.25,
      );

      expect(result.shouldIncreaseLoad, isTrue);
      expect(result.suggestedNewLoad, 41.25);
    });

    // ── Caso 3: Nem todas no máximo → manter carga ──
    test('nem todas as séries no máximo → sem progressão', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: 12),
        _makeSet(setNumber: 2, repsCompleted: 10),
        _makeSet(setNumber: 3, repsCompleted: 11),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isFalse);
      expect(result.suggestedNewLoad, isNull);
    });

    // ── Caso 4: 2 sessões consecutivas abaixo do rep_min → sugerir redução ──
    test('2 sessões abaixo do rep_min → shouldDecreaseLoad = true', () {
      final currentSets = [
        _makeSet(setNumber: 1, repsCompleted: 5),
        _makeSet(setNumber: 2, repsCompleted: 4),
        _makeSet(setNumber: 3, repsCompleted: 6),
      ];

      final previousSets = [
        _makeSet(setNumber: 1, repsCompleted: 6),
        _makeSet(setNumber: 2, repsCompleted: 5),
        _makeSet(setNumber: 3, repsCompleted: 7),
      ];

      final result = ProgressionEngine.analyze(
        sets: currentSets,
        repMin: 8,
        repMax: 12,
        currentLoad: 60,
        increment: 2.5,
        previousSessionSets: previousSets,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isTrue);
      expect(result.suggestedNewLoad, 57.5);
      expect(result.message, isNotNull);
    });

    // ── Caso 5: 1 sessão abaixo do mínimo, sem sessão anterior → sem redução ──
    test('1 sessão abaixo do mínimo sem sessão anterior → sem redução', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: 5),
        _makeSet(setNumber: 2, repsCompleted: 4),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isFalse);
    });

    // ── Caso 6: 1 sessão abaixo do mínimo + anterior OK → sem redução ──
    test('1 sessão abaixo + anterior OK → sem redução', () {
      final currentSets = [
        _makeSet(setNumber: 1, repsCompleted: 5),
        _makeSet(setNumber: 2, repsCompleted: 6),
      ];

      final previousSets = [
        _makeSet(setNumber: 1, repsCompleted: 9),
        _makeSet(setNumber: 2, repsCompleted: 10),
      ];

      final result = ProgressionEngine.analyze(
        sets: currentSets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
        previousSessionSets: previousSets,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isFalse);
    });

    // ── Caso 7: Sets vazios → sem sugestão ──
    test('sets vazios → sem sugestão', () {
      final result = ProgressionEngine.analyze(
        sets: [],
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isFalse);
      expect(result.suggestedNewLoad, isNull);
      expect(result.hasAction, isFalse);
    });

    // ── Caso 8: 1 única série no máximo → aumentar carga ──
    test('1 única série no máximo → shouldIncreaseLoad = true', () {
      final sets = [_makeSet(setNumber: 1, repsCompleted: 12)];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 30,
        increment: 0.5,
      );

      expect(result.shouldIncreaseLoad, isTrue);
      expect(result.suggestedNewLoad, 30.5);
    });

    // ── Caso 9: Séries skipped são ignoradas ──
    test('séries skipped são ignoradas na análise', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: 12),
        _makeSet(setNumber: 2, repsCompleted: 12),
        _makeSet(setNumber: 3, repsCompleted: 6, wasSkipped: true),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      // As 2 séries efetivas ambas em 12 → deve aumentar
      expect(result.shouldIncreaseLoad, isTrue);
      expect(result.suggestedNewLoad, 52.5);
    });

    // ── Caso 10: Todas séries skipped = sets efetivos vazios → sem sugestão ──
    test('todas as séries skipped → sem sugestão', () {
      final sets = [
        _makeSet(setNumber: 1, wasSkipped: true),
        _makeSet(setNumber: 2, wasSkipped: true),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isFalse);
      expect(result.hasAction, isFalse);
    });

    // ── Caso 11: Redução não resulta em carga negativa (clamp em 0) ──
    test('redução com carga muito baixa → clamp em 0', () {
      final currentSets = [
        _makeSet(setNumber: 1, repsCompleted: 3),
        _makeSet(setNumber: 2, repsCompleted: 2),
      ];

      final previousSets = [
        _makeSet(setNumber: 1, repsCompleted: 4),
        _makeSet(setNumber: 2, repsCompleted: 3),
      ];

      final result = ProgressionEngine.analyze(
        sets: currentSets,
        repMin: 8,
        repMax: 12,
        currentLoad: 1.0,
        increment: 2.5,
        previousSessionSets: previousSets,
      );

      expect(result.shouldDecreaseLoad, isTrue);
      expect(result.suggestedNewLoad, 0.0);
    });

    // ── Caso 12: repsCompleted null tratado como 0 ──
    test('repsCompleted null é tratado como 0', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: null),
        _makeSet(setNumber: 2, repsCompleted: null),
      ];

      final previousSets = [
        _makeSet(setNumber: 1, repsCompleted: null),
        _makeSet(setNumber: 2, repsCompleted: null),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
        previousSessionSets: previousSets,
      );

      // null (= 0) < repMin (8) em ambas sessões → redução
      expect(result.shouldDecreaseLoad, isTrue);
    });

    // ── Caso 13: Séries na faixa (entre min e max) → manter ──
    test('séries dentro da faixa, sem atingir max → manter', () {
      final sets = [
        _makeSet(setNumber: 1, repsCompleted: 9),
        _makeSet(setNumber: 2, repsCompleted: 10),
        _makeSet(setNumber: 3, repsCompleted: 11),
      ];

      final result = ProgressionEngine.analyze(
        sets: sets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );

      expect(result.shouldIncreaseLoad, isFalse);
      expect(result.shouldDecreaseLoad, isFalse);
    });

    // ── Caso 14: previousSessionSets com séries skipped → ignora skipped ──
    test('sessão anterior com séries skipped → ignora na análise', () {
      final currentSets = [
        _makeSet(setNumber: 1, repsCompleted: 5),
        _makeSet(setNumber: 2, repsCompleted: 6),
      ];

      // Sessão anterior: séries efetivas acima do mínimo,
      // mas tem série skipped
      final previousSets = [
        _makeSet(setNumber: 1, repsCompleted: 10),
        _makeSet(setNumber: 2, repsCompleted: 9),
        _makeSet(setNumber: 3, wasSkipped: true),
      ];

      final result = ProgressionEngine.analyze(
        sets: currentSets,
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
        previousSessionSets: previousSets,
      );

      // Anterior OK (10, 9 ≥ 8) → não reduz mesmo com atual abaixo
      expect(result.shouldDecreaseLoad, isFalse);
    });

    // ── Caso 15: hasAction correto ──
    test('hasAction retorna true para aumento e redução', () {
      final increaseResult = ProgressionEngine.analyze(
        sets: [_makeSet(repsCompleted: 12)],
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );
      expect(increaseResult.hasAction, isTrue);

      final noActionResult = ProgressionEngine.analyze(
        sets: [_makeSet(repsCompleted: 10)],
        repMin: 8,
        repMax: 12,
        currentLoad: 50,
        increment: 2.5,
      );
      expect(noActionResult.hasAction, isFalse);
    });
  });
}
