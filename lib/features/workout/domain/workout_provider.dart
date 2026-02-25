import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/providers/database_provider.dart';
import '../../programs/domain/program_day.dart';
import '../../programs/domain/programs_provider.dart';
import '../data/workout_dao.dart';
import 'set_record.dart';
import 'workout_session.dart';
import 'workout_state.dart';

// ─────────────── DAOs ───────────────

/// Provider do WorkoutDao.
final workoutDaoProvider = Provider<WorkoutDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.workoutDao;
});

// ─────────────── Computed ───────────────

/// Próximo dia a treinar com base no programa ativo e última sessão concluída.
/// Retorna null se não há programa ativo ou dias cadastrados.
final nextWorkoutDayProvider = FutureProvider.autoDispose<ProgramDay?>((
  ref,
) async {
  final activeProgram = ref.watch(activeProgramProvider).valueOrNull;
  if (activeProgram == null) return null;

  final days = ref.watch(programDaysProvider(activeProgram.id)).valueOrNull;
  if (days == null || days.isEmpty) return null;

  final dao = ref.read(workoutDaoProvider);
  final lastSession = await dao.getLastCompletedSessionForProgram(
    activeProgram.id,
  );

  if (lastSession == null) return days.first;

  final lastIndex = days.indexWhere((d) => d.id == lastSession.programDayId);
  if (lastIndex == -1) return days.first;

  final nextIndex = (lastIndex + 1) % days.length;
  return days[nextIndex];
});

// ─────────────── Notifier ───────────────

/// Gerencia o estado completo da sessão de treino ativa.
/// keepAlive (sem autoDispose) — persiste enquanto o app estiver rodando.
/// Na inicialização, restaura sessão in_progress caso exista (recovery de crash).
class ActiveWorkoutNotifier extends AsyncNotifier<WorkoutState?> {
  @override
  Future<WorkoutState?> build() async {
    final dao = ref.read(workoutDaoProvider);
    final existing = await dao.getActiveSession();
    if (existing == null) return null;

    // Restaura sessão in_progress — recovery de crash
    await WakelockPlus.enable();
    return _buildState(existing, dao);
  }

  // ─── helpers internos ───

  Future<WorkoutState> _buildState(
    WorkoutSession session,
    WorkoutDao dao,
  ) async {
    final dayName = await dao.getDayName(session.programDayId);
    final exercises = await dao.getExercisesForDay(session.programDayId);

    final allSets = await dao.getSetsForSession(session.id);
    final recordedSets = <int, List<SetRecord>>{};
    for (final s in allSets) {
      recordedSets.putIfAbsent(s.programExerciseId, () => []).add(s);
    }

    final lastLoads = <int, double>{};
    for (final ex in exercises) {
      final load = await dao.getLastLoadForProgramExercise(ex.id);
      if (load != null) lastLoads[ex.id] = load;
    }

    return WorkoutState(
      session: session,
      dayName: dayName,
      exercises: exercises,
      recordedSets: recordedSets,
      lastSessionLoad: lastLoads,
    );
  }

  // ─── ações públicas ───

  /// Inicia uma nova sessão de treino para o dia informado.
  Future<void> startWorkout(int programDayId) async {
    state = const AsyncLoading();
    final dao = ref.read(workoutDaoProvider);

    // Cancela sessão anterior não concluída, se existir
    final existing = await dao.getActiveSession();
    if (existing != null) {
      await dao.cancelSession(existing.id);
    }

    final sessionId = await dao.createSession(programDayId);
    final session = await dao.getSessionById(sessionId);
    if (session == null) {
      state = const AsyncData(null);
      return;
    }

    await WakelockPlus.enable();
    final workoutState = await _buildState(session, dao);
    state = AsyncData(workoutState);
  }

  /// Registra uma série confirmada — auto-save imediato.
  Future<void> recordSet({
    required int programExerciseId,
    required int setNumber,
    double? loadKg,
    int? repsCompleted,
    int? rpeAchieved,
    bool isExtra = false,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final dao = ref.read(workoutDaoProvider);
    final savedId = await dao.saveSet(
      sessionId: current.session.id,
      programExerciseId: programExerciseId,
      setNumber: setNumber,
      loadKg: loadKg,
      repsCompleted: repsCompleted,
      rpeAchieved: rpeAchieved,
      isExtra: isExtra,
    );

    final newRecord = SetRecord(
      id: savedId,
      sessionId: current.session.id,
      programExerciseId: programExerciseId,
      setNumber: setNumber,
      loadKg: loadKg,
      repsCompleted: repsCompleted,
      rpeAchieved: rpeAchieved,
      recordedAt: DateTime.now(),
      isExtra: isExtra,
    );

    final updatedSets = Map<int, List<SetRecord>>.from(current.recordedSets);
    updatedSets[programExerciseId] = [
      ...updatedSets[programExerciseId] ?? [],
      newRecord,
    ];

    state = AsyncData(current.copyWith(recordedSets: updatedSets));
  }

  /// Pula uma série marcando wasSkipped = true.
  Future<void> skipSet({
    required int programExerciseId,
    required int setNumber,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final dao = ref.read(workoutDaoProvider);
    final savedId = await dao.saveSet(
      sessionId: current.session.id,
      programExerciseId: programExerciseId,
      setNumber: setNumber,
      wasSkipped: true,
    );

    final newRecord = SetRecord(
      id: savedId,
      sessionId: current.session.id,
      programExerciseId: programExerciseId,
      setNumber: setNumber,
      recordedAt: DateTime.now(),
      wasSkipped: true,
    );

    final updatedSets = Map<int, List<SetRecord>>.from(current.recordedSets);
    updatedSets[programExerciseId] = [
      ...updatedSets[programExerciseId] ?? [],
      newRecord,
    ];

    state = AsyncData(current.copyWith(recordedSets: updatedSets));
  }

  /// Navega para um exercício pelo índice (usado pelo PageView e botões).
  void goToExercise(int index) {
    final current = state.valueOrNull;
    if (current == null) return;
    if (index < 0 || index >= current.exercises.length) return;
    state = AsyncData(current.copyWith(currentExerciseIndex: index));
  }

  /// Finaliza a sessão como concluída.
  Future<void> finishWorkout() async {
    final current = state.valueOrNull;
    if (current == null) return;

    final dao = ref.read(workoutDaoProvider);
    await dao.completeSession(current.session.id);

    final updatedSession = current.session.copyWith(
      status: 'completed',
      finishedAt: DateTime.now(),
    );
    state = AsyncData(current.copyWith(session: updatedSession));
    await WakelockPlus.disable();
  }

  /// Abandona a sessão sem marcar como concluída.
  Future<void> abandonWorkout() async {
    final current = state.valueOrNull;
    if (current == null) return;

    final dao = ref.read(workoutDaoProvider);
    await dao.cancelSession(current.session.id);

    state = const AsyncData(null);
    await WakelockPlus.disable();
  }

  /// Reseta o estado após o usuário dispensar a tela de resumo.
  void resetAfterSummary() {
    state = const AsyncData(null);
  }
}

final activeWorkoutProvider =
    AsyncNotifierProvider<ActiveWorkoutNotifier, WorkoutState?>(
      ActiveWorkoutNotifier.new,
    );
