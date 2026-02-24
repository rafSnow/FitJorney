/// Enums de classificação de exercícios.
///
/// Baseados em Kraemer & Ratamess (2004) — classificação científica
/// para determinar incrementos de carga.
library;

/// Tamanho do grupo muscular.
enum MuscleSize {
  large('large', 'Grande'),
  small('small', 'Pequeno');

  const MuscleSize(this.value, this.label);
  final String value;
  final String label;

  static MuscleSize fromString(String s) =>
      values.firstWhere((e) => e.value == s, orElse: () => large);
}

/// Tipo de exercício (composto vs isolado).
enum ExerciseType {
  compound('compound', 'Composto'),
  isolation('isolation', 'Isolado');

  const ExerciseType(this.value, this.label);
  final String value;
  final String label;

  static ExerciseType fromString(String s) =>
      values.firstWhere((e) => e.value == s, orElse: () => compound);
}

/// Tipo de métrica de registro.
enum MetricType {
  loadKg('load_kg', 'Carga (kg)'),
  timeSeconds('time_seconds', 'Tempo (seg)');

  const MetricType(this.value, this.label);
  final String value;
  final String label;

  static MetricType fromString(String s) =>
      values.firstWhere((e) => e.value == s, orElse: () => loadKg);
}

/// Grupos musculares disponíveis.
enum MuscleGroup {
  chest('chest', 'Peito'),
  back('back', 'Costas'),
  shoulders('shoulders', 'Ombros'),
  biceps('biceps', 'Bíceps'),
  triceps('triceps', 'Tríceps'),
  forearm('forearm', 'Antebraço'),
  quadriceps('quadriceps', 'Quadríceps'),
  hamstrings('hamstrings', 'Posterior de Coxa'),
  glutes('glutes', 'Glúteos'),
  calves('calves', 'Panturrilha'),
  core('core', 'Core'),
  fullBody('fullBody', 'Full Body');

  const MuscleGroup(this.value, this.label);
  final String value;
  final String label;

  static MuscleGroup fromString(String s) =>
      values.firstWhere((e) => e.value == s, orElse: () => chest);

  /// Retorna o tamanho padrão do grupo muscular.
  MuscleSize get defaultSize => switch (this) {
    MuscleGroup.chest => MuscleSize.large,
    MuscleGroup.back => MuscleSize.large,
    MuscleGroup.shoulders => MuscleSize.small,
    MuscleGroup.biceps => MuscleSize.small,
    MuscleGroup.triceps => MuscleSize.small,
    MuscleGroup.forearm => MuscleSize.small,
    MuscleGroup.quadriceps => MuscleSize.large,
    MuscleGroup.hamstrings => MuscleSize.large,
    MuscleGroup.glutes => MuscleSize.large,
    MuscleGroup.calves => MuscleSize.small,
    MuscleGroup.core => MuscleSize.small,
    MuscleGroup.fullBody => MuscleSize.large,
  };
}
