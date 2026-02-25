/// Estado imutável do cronômetro de descanso.
class RestTimerState {
  const RestTimerState({
    this.totalSeconds = 0,
    this.remainingSeconds = 0,
    this.isRunning = false,
    this.exerciseName = '',
  });

  /// Duração original configurada para este descanso.
  final int totalSeconds;

  /// Segundos restantes.
  final int remainingSeconds;

  /// True enquanto o cronômetro estiver ativo (inclusive no último segundo).
  final bool isRunning;

  /// Nome do exercício que gerou este descanso.
  final String exerciseName;

  /// Progresso de 0.0 (início) a 1.0 (concluído).
  double get progress =>
      totalSeconds > 0 ? remainingSeconds / totalSeconds : 0.0;

  /// True quando o timer chegou a zero (visualmente = "concluído").
  bool get isDone => totalSeconds > 0 && remainingSeconds == 0;

  RestTimerState copyWith({
    int? totalSeconds,
    int? remainingSeconds,
    bool? isRunning,
    String? exerciseName,
  }) => RestTimerState(
    totalSeconds: totalSeconds ?? this.totalSeconds,
    remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    isRunning: isRunning ?? this.isRunning,
    exerciseName: exerciseName ?? this.exerciseName,
  );
}
