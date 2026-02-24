import 'package:freezed_annotation/freezed_annotation.dart';

part 'program.freezed.dart';
part 'program.g.dart';

/// Entidade de domínio de programa de treino.
@freezed
abstract class Program with _$Program {
  const factory Program({
    required int id,
    required String name,
    @Default(false) bool isActive,
    required DateTime createdAt,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
