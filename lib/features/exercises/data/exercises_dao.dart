import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/exercise_enums.dart';
import '../domain/exercise.dart' as domain;
import 'exercises_table.dart';

part 'exercises_dao.g.dart';

/// DAO de exercícios — CRUD completo + streams reativos.
@DriftAccessor(tables: [Exercises])
class ExercisesDao extends DatabaseAccessor<AppDatabase>
    with _$ExercisesDaoMixin {
  ExercisesDao(super.db);

  /// Converte um registro Drift para a entidade de domínio.
  domain.Exercise _toDomain(Exercise row) {
    return domain.Exercise(
      id: row.id,
      name: row.name,
      muscleGroup: MuscleGroup.fromString(row.muscleGroup),
      muscleSize: MuscleSize.fromString(row.muscleSize),
      exerciseType: ExerciseType.fromString(row.exerciseType),
      metricType: MetricType.fromString(row.metricType),
      youtubeUrl: row.youtubeUrl,
      customIncrement: row.customIncrement,
      createdAt: row.createdAt,
      isDeleted: row.isDeleted,
    );
  }

  /// Stream de todos os exercícios ativos (não deletados), ordenados por nome.
  Stream<List<domain.Exercise>> watchAll() {
    final query = select(exercises)
      ..where((e) => e.isDeleted.equals(false))
      ..orderBy([(e) => OrderingTerm.asc(e.name)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  /// Busca um exercício por id.
  Future<domain.Exercise?> getById(int id) async {
    final query = select(exercises)..where((e) => e.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _toDomain(row) : null;
  }

  /// Stream de um exercício específico.
  Stream<domain.Exercise?> watchById(int id) {
    final query = select(exercises)..where((e) => e.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row != null ? _toDomain(row) : null,
    );
  }

  /// Insere um novo exercício e retorna o id.
  Future<int> insertExercise({
    required String name,
    required MuscleGroup muscleGroup,
    required MuscleSize muscleSize,
    required ExerciseType exerciseType,
    required MetricType metricType,
    String? youtubeUrl,
    double? customIncrement,
  }) {
    return into(exercises).insert(
      ExercisesCompanion.insert(
        name: name,
        muscleGroup: muscleGroup.value,
        muscleSize: muscleSize.value,
        exerciseType: exerciseType.value,
        metricType: metricType.value,
        youtubeUrl: Value(youtubeUrl),
        customIncrement: Value(customIncrement),
      ),
    );
  }

  /// Atualiza um exercício existente.
  Future<bool> updateExercise({
    required int id,
    required String name,
    required MuscleGroup muscleGroup,
    required MuscleSize muscleSize,
    required ExerciseType exerciseType,
    required MetricType metricType,
    String? youtubeUrl,
    double? customIncrement,
  }) {
    return (update(exercises)..where((e) => e.id.equals(id)))
        .write(
          ExercisesCompanion(
            name: Value(name),
            muscleGroup: Value(muscleGroup.value),
            muscleSize: Value(muscleSize.value),
            exerciseType: Value(exerciseType.value),
            metricType: Value(metricType.value),
            youtubeUrl: Value(youtubeUrl),
            customIncrement: Value(customIncrement),
          ),
        )
        .then((rows) => rows > 0);
  }

  /// Soft delete — marca como deletado (nunca remove fisicamente).
  Future<void> softDelete(int id) {
    return (update(exercises)..where((e) => e.id.equals(id))).write(
      const ExercisesCompanion(isDeleted: Value(true)),
    );
  }

  /// Verifica se o exercício está em uso em algum programa (qualquer programa).
  Future<bool> isInAnyProgram(int exerciseId) async {
    final query = selectOnly(db.programExercises)
      ..addColumns([db.programExercises.id])
      ..where(db.programExercises.exerciseId.equals(exerciseId))
      ..limit(1);
    final result = await query.get();
    return result.isNotEmpty;
  }

  /// Verifica se o exercício está em algum programa ativo.
  Future<bool> isInActiveProgram(int exerciseId) async {
    final query =
        select(db.programExercises).join([
            innerJoin(
              db.programDays,
              db.programDays.id.equalsExp(db.programExercises.programDayId),
            ),
            innerJoin(
              db.programs,
              db.programs.id.equalsExp(db.programDays.programId),
            ),
          ])
          ..where(db.programExercises.exerciseId.equals(exerciseId))
          ..where(db.programs.isActive.equals(true))
          ..limit(1);
    final result = await query.get();
    return result.isNotEmpty;
  }

  /// Busca exercícios por nome (para busca na tela).
  Stream<List<domain.Exercise>> watchByName(String searchTerm) {
    final query = select(exercises)
      ..where((e) => e.isDeleted.equals(false) & e.name.like('%$searchTerm%'))
      ..orderBy([(e) => OrderingTerm.asc(e.name)]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }
}
