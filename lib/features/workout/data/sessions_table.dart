import 'package:drift/drift.dart';

import '../../programs/data/program_days_table.dart';

/// Tabela de sessões de treino.
class WorkoutSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get programDayId => integer().references(ProgramDays, #id)();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('in_progress'))();
}
