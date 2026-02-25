import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../programs/domain/program_exercise.dart';
import '../../workout/data/workout_dao.dart';
import '../../workout/domain/progression_engine.dart';
import '../../workout/domain/set_record.dart';
import '../../workout/domain/workout_provider.dart';

// ─────────────── Filtro ───────────────

/// Filtro de período para o histórico.
enum HistoryFilter { week, month, all }

/// Provider do filtro atual.
final historyFilterProvider = StateProvider<HistoryFilter>(
  (ref) => HistoryFilter.all,
);

// ─────────────── Model ───────────────

/// Sessão resumida para a listagem do histórico.
class HistorySession {
  const HistorySession({
    required this.id,
    required this.startedAt,
    this.finishedAt,
    required this.dayName,
    required this.programName,
    required this.programDayId,
    required this.hadProgression,
  });

  final int id;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final String dayName;
  final String programName;
  final int programDayId;
  final bool hadProgression;

  Duration get duration {
    final end = finishedAt ?? startedAt;
    return end.difference(startedAt);
  }
}

/// Exercício detalhado dentro de uma sessão histórica.
class SessionExerciseDetail {
  const SessionExerciseDetail({
    required this.exercise,
    required this.sets,
    this.progression,
  });

  final ProgramExercise exercise;
  final List<SetRecord> sets;
  final ProgressionResult? progression;
}

/// Detalhes completos de uma sessão.
class SessionDetail {
  const SessionDetail({
    required this.sessionId,
    required this.startedAt,
    this.finishedAt,
    required this.dayName,
    required this.programName,
    required this.exercises,
  });

  final int sessionId;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final String dayName;
  final String programName;
  final List<SessionExerciseDetail> exercises;

  Duration get duration {
    final end = finishedAt ?? startedAt;
    return end.difference(startedAt);
  }
}

// ─────────────── Providers ───────────────

/// Stream de sessões do histórico com dados enriquecidos.
final historySessionsProvider =
    StreamProvider.autoDispose<List<HistorySession>>((ref) {
      final dao = ref.watch(workoutDaoProvider);
      final filter = ref.watch(historyFilterProvider);

      return dao.watchCompletedSessionsWithInfo().asyncMap((sessions) async {
        // Filtrar por período
        final now = DateTime.now();
        final cutoff = switch (filter) {
          HistoryFilter.week => now.subtract(const Duration(days: 7)),
          HistoryFilter.month => now.subtract(const Duration(days: 30)),
          HistoryFilter.all => null,
        };

        final filtered = cutoff != null
            ? sessions.where((s) => s.startedAt.isAfter(cutoff)).toList()
            : sessions;

        // Buscar dados para checar progressão em batch
        final dayIds = filtered.map((s) => s.programDayId).toSet();
        final exercisesPerDay = <int, List<ProgramExercise>>{};
        for (final dayId in dayIds) {
          exercisesPerDay[dayId] = await dao.getExercisesForDay(dayId);
        }

        final enriched = <HistorySession>[];
        for (final s in filtered) {
          final hadProg = await _checkSessionProgression(
            dao,
            s.id,
            s.programDayId,
            exercisesPerDay[s.programDayId] ?? [],
          );
          enriched.add(
            HistorySession(
              id: s.id,
              startedAt: s.startedAt,
              finishedAt: s.finishedAt,
              dayName: s.dayName,
              programName: s.programName,
              programDayId: s.programDayId,
              hadProgression: hadProg,
            ),
          );
        }

        return enriched;
      });
    });

/// Verifica se algum exercício da sessão atingiu progressão
/// (todas as séries não-puladas atingiram rep_max).
Future<bool> _checkSessionProgression(
  WorkoutDao dao,
  int sessionId,
  int programDayId,
  List<ProgramExercise> exercises,
) async {
  if (exercises.isEmpty) return false;
  final sets = await dao.getSetsForSession(sessionId);

  for (final ex in exercises) {
    final exSets = sets
        .where((s) => s.programExerciseId == ex.id && !s.wasSkipped)
        .toList();
    if (exSets.isEmpty) continue;

    final allAtMax = exSets.every((s) => (s.repsCompleted ?? 0) >= ex.repMax);
    if (allAtMax) return true;
  }

  return false;
}

/// Detalhes completos de uma sessão específica.
final sessionDetailProvider = FutureProvider.autoDispose
    .family<SessionDetail?, int>((ref, sessionId) async {
      final dao = ref.read(workoutDaoProvider);

      // Buscar sessão
      final session = await dao.getSessionById(sessionId);
      if (session == null) return null;

      // Buscar nomes
      final dayName = await dao.getDayName(session.programDayId);
      final programName = await dao.getProgramNameForDay(session.programDayId);

      // Buscar exercícios do dia
      final exercises = await dao.getExercisesForDay(session.programDayId);

      // Buscar todas as séries desta sessão
      final allSets = await dao.getSetsForSession(sessionId);

      // Construir detalhes por exercício com análise de progressão
      final exerciseDetails = <SessionExerciseDetail>[];
      for (final ex in exercises) {
        final exSets = allSets
            .where((s) => s.programExerciseId == ex.id)
            .toList();

        // Buscar séries da sessão anterior para análise de progressão
        final prevSets = await dao.getPreviousSetsForExercise(sessionId, ex.id);

        // Carga máxima usada nesta sessão para o exercício
        final nonSkippedSets = exSets.where((s) => !s.wasSkipped);
        final currentLoad = nonSkippedSets.isEmpty
            ? 0.0
            : nonSkippedSets
                  .where((s) => s.loadKg != null)
                  .fold(0.0, (max, s) => s.loadKg! > max ? s.loadKg! : max);

        // Buscar incremento real
        final details = await dao.getExerciseDetailsForProgression(ex.id);
        double increment = 2.5;
        if (details != null) {
          increment =
              details.customIncrement ??
              ProgressionConstants.getSuggestedIncrement(
                details.muscleSize == 'large'
                    ? MuscleSize.large
                    : MuscleSize.small,
                details.exerciseType == 'compound'
                    ? ExerciseType.compound
                    : ExerciseType.isolation,
              );
        }

        final progression = ProgressionEngine.analyze(
          sets: exSets,
          repMin: ex.repMin,
          repMax: ex.repMax,
          currentLoad: currentLoad,
          increment: increment,
          previousSessionSets: prevSets,
        );

        exerciseDetails.add(
          SessionExerciseDetail(
            exercise: ex,
            sets: exSets,
            progression: progression.hasAction ? progression : null,
          ),
        );
      }

      return SessionDetail(
        sessionId: sessionId,
        startedAt: session.startedAt,
        finishedAt: session.finishedAt,
        dayName: dayName,
        programName: programName,
        exercises: exerciseDetails,
      );
    });
