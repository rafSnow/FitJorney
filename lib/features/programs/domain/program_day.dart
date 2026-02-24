import 'package:freezed_annotation/freezed_annotation.dart';

part 'program_day.freezed.dart';
part 'program_day.g.dart';

/// Entidade de domínio de um dia do programa.
@freezed
abstract class ProgramDay with _$ProgramDay {
  const factory ProgramDay({
    required int id,
    required int programId,
    required String name,
    required int dayOrder,
  }) = _ProgramDay;

  factory ProgramDay.fromJson(Map<String, dynamic> json) =>
      _$ProgramDayFromJson(json);
}
