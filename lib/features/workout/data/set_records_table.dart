import 'package:drift/drift.dart';

import '../../programs/data/program_exercises_table.dart';
import 'sessions_table.dart';

/// Tabela de registros de séries em uma sessão.
class SetRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(WorkoutSessions, #id)();
  IntColumn get programExerciseId =>
      integer().references(ProgramExercises, #id)();
  IntColumn get setNumber => integer()();
  RealColumn get loadKg => real().nullable()();
  IntColumn get timeSeconds => integer().nullable()();
  IntColumn get repsCompleted => integer().nullable()();
  IntColumn get rpeAchieved => integer().nullable()();
  DateTimeColumn get recordedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isExtra => boolean().withDefault(const Constant(false))();
  BoolColumn get wasSkipped => boolean().withDefault(const Constant(false))();
}
