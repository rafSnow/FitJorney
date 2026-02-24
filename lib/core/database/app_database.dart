import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/exercises/data/exercises_table.dart';
import '../../features/programs/data/program_days_table.dart';
import '../../features/programs/data/program_exercises_table.dart';
import '../../features/programs/data/programs_table.dart';
import '../../features/workout/data/sessions_table.dart';
import '../../features/workout/data/set_records_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Exercises,
    Programs,
    ProgramDays,
    ProgramExercises,
    WorkoutSessions,
    SetRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'fitjourney');
  }
}
