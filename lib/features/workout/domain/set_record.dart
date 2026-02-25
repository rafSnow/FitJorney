import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_record.freezed.dart';

/// Entidade de domínio de um registro de série.
@freezed
abstract class SetRecord with _$SetRecord {
  const factory SetRecord({
    required int id,
    required int sessionId,
    required int programExerciseId,
    required int setNumber,
    double? loadKg,
    int? timeSeconds,
    int? repsCompleted,
    int? rpeAchieved,
    required DateTime recordedAt,
    @Default(false) bool isExtra,
    @Default(false) bool wasSkipped,
  }) = _SetRecord;
}
