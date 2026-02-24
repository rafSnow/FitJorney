import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_enums.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

/// Entidade de domínio de exercício.
@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required int id,
    required String name,
    required MuscleGroup muscleGroup,
    required MuscleSize muscleSize,
    required ExerciseType exerciseType,
    required MetricType metricType,
    String? youtubeUrl,
    double? customIncrement,
    required DateTime createdAt,
    @Default(false) bool isDeleted,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
