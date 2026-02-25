import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exercises/domain/exercise.dart';
import '../../exercises/domain/exercise_enums.dart';
import '../../exercises/domain/exercises_provider.dart';
import '../../workout/domain/workout_provider.dart';

// ─────────────── Models ───────────────

/// Ponto no gráfico de evolução de carga.
class LoadDataPoint {
  const LoadDataPoint({
    required this.date,
    required this.maxLoad,
    required this.reps,
  });

  final DateTime date;
  final double maxLoad;
  final int reps;
}

/// Volume semanal de um grupo muscular.
class MuscleGroupVolume {
  const MuscleGroupVolume({
    required this.muscleGroup,
    required this.label,
    required this.totalSets,
  });

  final String muscleGroup;
  final String label;
  final int totalSets;
}

// ─────────────── Providers ───────────────

/// Exercício selecionado para visualizar no gráfico.
final selectedExerciseProvider = StateProvider<Exercise?>((ref) => null);

/// Lista de exercícios que têm dados de carga registrados.
/// Filtra exercícios com metricType == loadKg (gráfico de carga só faz sentido para eles).
final exercisesWithLoadDataProvider =
    FutureProvider.autoDispose<List<Exercise>>((ref) async {
      final exercises = ref.watch(exercisesProvider).valueOrNull ?? [];
      final dao = ref.read(workoutDaoProvider);

      final result = <Exercise>[];
      for (final ex in exercises) {
        if (ex.metricType != MetricType.loadKg) continue;
        final history = await dao.getLoadHistoryForExercise(ex.id);
        if (history.isNotEmpty) {
          result.add(ex);
        }
      }
      return result;
    });

/// Dados de evolução de carga para o exercício selecionado.
final loadHistoryProvider = FutureProvider.autoDispose<List<LoadDataPoint>>((
  ref,
) async {
  final exercise = ref.watch(selectedExerciseProvider);
  if (exercise == null) return [];

  final dao = ref.read(workoutDaoProvider);
  final history = await dao.getLoadHistoryForExercise(exercise.id);

  return history
      .map((h) => LoadDataPoint(date: h.date, maxLoad: h.maxLoad, reps: h.reps))
      .toList();
});

/// Streak semanal: dias em que houve treino nesta semana (seg-dom).
final weeklyStreakProvider = FutureProvider.autoDispose<List<bool>>((
  ref,
) async {
  final dao = ref.read(workoutDaoProvider);
  final dates = await dao.getWorkoutDatesThisWeek();

  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));

  // 7 posições: seg=0, ter=1, ..., dom=6
  final streak = List<bool>.filled(7, false);
  for (final date in dates) {
    final dayIndex = date
        .difference(DateTime(monday.year, monday.month, monday.day))
        .inDays;
    if (dayIndex >= 0 && dayIndex < 7) {
      streak[dayIndex] = true;
    }
  }

  return streak;
});

/// Volume semanal por grupo muscular.
final weeklyVolumeProvider =
    FutureProvider.autoDispose<List<MuscleGroupVolume>>((ref) async {
      final dao = ref.read(workoutDaoProvider);
      final rawVolume = await dao.getWeeklyVolumeByMuscleGroup();

      return rawVolume
          .map(
            (v) => MuscleGroupVolume(
              muscleGroup: v.muscleGroup,
              label: MuscleGroup.fromString(v.muscleGroup).label,
              totalSets: v.totalSets,
            ),
          )
          .toList();
    });
