import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_session.freezed.dart';

/// Entidade de domínio de uma sessão de treino.
@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required int id,
    required int programDayId,
    required DateTime startedAt,
    DateTime? finishedAt,
    @Default('in_progress') String status,
  }) = _WorkoutSession;

  const WorkoutSession._();

  bool get isInProgress => status == 'in_progress';
  bool get isCompleted => status == 'completed';

  Duration get elapsed {
    final end = finishedAt ?? DateTime.now();
    return end.difference(startedAt);
  }
}
