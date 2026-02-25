import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/exercises/data/exercises_dao.dart';
import '../../features/exercises/data/exercises_table.dart';
import '../../features/programs/data/program_days_table.dart';
import '../../features/programs/data/program_exercises_table.dart';
import '../../features/programs/data/programs_dao.dart';
import '../../features/programs/data/programs_table.dart';
import '../../features/workout/data/sessions_table.dart';
import '../../features/workout/data/set_records_table.dart';
import '../../features/workout/data/workout_dao.dart';

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
  daos: [ExercisesDao, ProgramsDao, WorkoutDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // Adiciona coluna nextSuggestedLoad à tabela program_exercises
        await m.addColumn(programExercises, programExercises.nextSuggestedLoad);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'fitjourney');
  }
}
