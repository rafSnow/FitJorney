import 'package:drift/drift.dart';

import '../../exercises/data/exercises_table.dart';
import 'program_days_table.dart';

/// Tabela de exercícios configurados em um dia do programa.
class ProgramExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get programDayId => integer().references(ProgramDays, #id)();
  IntColumn get exerciseId => integer().references(Exercises, #id)();
  IntColumn get exerciseOrder => integer()();
  IntColumn get sets => integer()();
  IntColumn get repMin => integer()();
  IntColumn get repMax => integer()();
  IntColumn get rpeTarget => integer().nullable()();
  IntColumn get restSeconds => integer().withDefault(const Constant(90))();
}
