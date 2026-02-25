import 'package:freezed_annotation/freezed_annotation.dart';

import '../../programs/domain/program_exercise.dart';
import 'set_record.dart';
import 'workout_session.dart';

part 'workout_state.freezed.dart';

/// Estado completo de uma sessão de treino ativa.
@freezed
abstract class WorkoutState with _$WorkoutState {
  const factory WorkoutState({
    required WorkoutSession session,
    required String dayName,
    required List<ProgramExercise> exercises,
    @Default(0) int currentExerciseIndex,
    // Key: programExerciseId → lista de SetRecord gravadas nesta sessão
    @Default({}) Map<int, List<SetRecord>> recordedSets,
    // Key: programExerciseId → última carga usada (pre-fill)
    @Default({}) Map<int, double> lastSessionLoad,
  }) = _WorkoutState;

  const WorkoutState._();

  ProgramExercise? get currentExercise =>
      exercises.isNotEmpty && currentExerciseIndex < exercises.length
      ? exercises[currentExerciseIndex]
      : null;

  List<SetRecord> setsForExercise(int programExerciseId) =>
      recordedSets[programExerciseId] ?? [];

  double lastLoadFor(int programExerciseId) =>
      lastSessionLoad[programExerciseId] ?? 0.0;

  /// Número da próxima série a confirmar para o exercício atual.
  int nextSetNumberFor(int programExerciseId) {
    final sets = setsForExercise(programExerciseId);
    if (sets.isEmpty) return 1;
    final lastSet = sets
        .where((s) => !s.isExtra || s.isExtra)
        .fold(0, (max, s) => s.setNumber > max ? s.setNumber : max);
    return lastSet + 1;
  }

  /// Verifica se todas as séries planejadas de um exercício foram concluídas.
  bool isExerciseComplete(int programExerciseIndex) {
    if (programExerciseIndex >= exercises.length) return false;
    final pe = exercises[programExerciseIndex];
    final sets = setsForExercise(pe.id);
    final doneSets = sets.where((s) => !s.isExtra).length;
    return doneSets >= pe.sets;
  }

  bool get allExercisesComplete =>
      exercises.every((ex) => isExerciseComplete(exercises.indexOf(ex)));
}
