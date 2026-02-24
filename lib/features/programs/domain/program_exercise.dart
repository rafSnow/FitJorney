import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_exercise.freezed.dart';
part 'program_exercise.g.dart';

/// Entidade de domínio de um exercício configurado em um dia do programa.
@freezed
abstract class ProgramExercise with _$ProgramExercise {
  const factory ProgramExercise({
    required int id,
    required int programDayId,
    required int exerciseId,
    required int exerciseOrder,
    required int sets,
    required int repMin,
    required int repMax,
    int? rpeTarget,
    @Default(90) int restSeconds,

    /// Nome do exercício (join do banco).
    String? exerciseName,
  }) = _ProgramExercise;

  factory ProgramExercise.fromJson(Map<String, dynamic> json) =>
      _$ProgramExerciseFromJson(json);
}
