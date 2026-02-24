import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../exercises/data/exercises_table.dart';
import '../domain/program.dart' as domain;
import '../domain/program_day.dart' as domain;
import '../domain/program_exercise.dart' as domain;
import 'program_days_table.dart';
import 'program_exercises_table.dart';
import 'programs_table.dart';

part 'programs_dao.g.dart';

/// DAO de programas — CRUD completo com queries aninhadas.
@DriftAccessor(tables: [Programs, ProgramDays, ProgramExercises, Exercises])
class ProgramsDao extends DatabaseAccessor<AppDatabase>
    with _$ProgramsDaoMixin {
  ProgramsDao(super.db);

  // ──────────── Conversões ────────────

  domain.Program _programToDomain(Program row) {
    return domain.Program(
      id: row.id,
      name: row.name,
      isActive: row.isActive,
      createdAt: row.createdAt,
    );
  }

  domain.ProgramDay _dayToDomain(ProgramDay row) {
    return domain.ProgramDay(
      id: row.id,
      programId: row.programId,
      name: row.name,
      dayOrder: row.dayOrder,
    );
  }

  domain.ProgramExercise _exerciseToDomain(
    ProgramExercise row,
    Exercise? exerciseRow,
  ) {
    return domain.ProgramExercise(
      id: row.id,
      programDayId: row.programDayId,
      exerciseId: row.exerciseId,
      exerciseOrder: row.exerciseOrder,
      sets: row.sets,
      repMin: row.repMin,
      repMax: row.repMax,
      rpeTarget: row.rpeTarget,
      restSeconds: row.restSeconds,
      exerciseName: exerciseRow?.name,
    );
  }

  // ──────────── Programs CRUD ────────────

  /// Stream de todos os programas, ordenados por nome.
  Stream<List<domain.Program>> watchAll() {
    final query = select(programs)
      ..orderBy([
        (p) => OrderingTerm.desc(p.isActive),
        (p) => OrderingTerm.asc(p.name),
      ]);
    return query.watch().map((rows) => rows.map(_programToDomain).toList());
  }

  /// Busca programa por id.
  Future<domain.Program?> getById(int id) async {
    final query = select(programs)..where((p) => p.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _programToDomain(row) : null;
  }

  /// Stream de um programa específico.
  Stream<domain.Program?> watchById(int id) {
    final query = select(programs)..where((p) => p.id.equals(id));
    return query.watchSingleOrNull().map(
      (row) => row != null ? _programToDomain(row) : null,
    );
  }

  /// Stream do programa ativo.
  Stream<domain.Program?> watchActive() {
    final query = select(programs)..where((p) => p.isActive.equals(true));
    return query.watchSingleOrNull().map(
      (row) => row != null ? _programToDomain(row) : null,
    );
  }

  /// Cria um programa e retorna o id.
  Future<int> insertProgram({required String name}) {
    return into(programs).insert(ProgramsCompanion.insert(name: name));
  }

  /// Atualiza o nome de um programa.
  Future<void> updateProgramName({required int id, required String name}) {
    return (update(programs)..where((p) => p.id.equals(id))).write(
      ProgramsCompanion(name: Value(name)),
    );
  }

  /// Ativa um programa (desativa todos os outros).
  Future<void> activateProgram(int programId) async {
    await transaction(() async {
      // Desativa todos
      await update(
        programs,
      ).write(const ProgramsCompanion(isActive: Value(false)));
      // Ativa o selecionado
      await (update(programs)..where((p) => p.id.equals(programId))).write(
        const ProgramsCompanion(isActive: Value(true)),
      );
    });
  }

  /// Desativa o programa ativo.
  Future<void> deactivateProgram(int programId) {
    return (update(programs)..where((p) => p.id.equals(programId))).write(
      const ProgramsCompanion(isActive: Value(false)),
    );
  }

  /// Deleta um programa e todos os seus dias/exercícios (cascade manual).
  Future<void> deleteProgram(int programId) async {
    await transaction(() async {
      // Busca os dias para deletar os exercícios
      final days = await (select(
        programDays,
      )..where((d) => d.programId.equals(programId))).get();
      for (final day in days) {
        await (delete(
          programExercises,
        )..where((pe) => pe.programDayId.equals(day.id))).go();
      }
      // Deleta os dias
      await (delete(
        programDays,
      )..where((d) => d.programId.equals(programId))).go();
      // Deleta o programa
      await (delete(programs)..where((p) => p.id.equals(programId))).go();
    });
  }

  // ──────────── Program Days ────────────

  /// Stream dos dias de um programa, ordenados por dayOrder.
  Stream<List<domain.ProgramDay>> watchDays(int programId) {
    final query = select(programDays)
      ..where((d) => d.programId.equals(programId))
      ..orderBy([(d) => OrderingTerm.asc(d.dayOrder)]);
    return query.watch().map((rows) => rows.map(_dayToDomain).toList());
  }

  /// Busca os dias de um programa.
  Future<List<domain.ProgramDay>> getDays(int programId) async {
    final query = select(programDays)
      ..where((d) => d.programId.equals(programId))
      ..orderBy([(d) => OrderingTerm.asc(d.dayOrder)]);
    final rows = await query.get();
    return rows.map(_dayToDomain).toList();
  }

  /// Insere um dia no programa.
  Future<int> insertDay({
    required int programId,
    required String name,
    required int dayOrder,
  }) {
    return into(programDays).insert(
      ProgramDaysCompanion.insert(
        programId: programId,
        name: name,
        dayOrder: dayOrder,
      ),
    );
  }

  /// Atualiza o nome de um dia.
  Future<void> updateDayName({required int dayId, required String name}) {
    return (update(programDays)..where((d) => d.id.equals(dayId))).write(
      ProgramDaysCompanion(name: Value(name)),
    );
  }

  /// Deleta um dia e seus exercícios.
  Future<void> deleteDay(int dayId) async {
    await transaction(() async {
      await (delete(
        programExercises,
      )..where((pe) => pe.programDayId.equals(dayId))).go();
      await (delete(programDays)..where((d) => d.id.equals(dayId))).go();
    });
  }

  /// Insere múltiplos dias de uma vez (para criação de programa).
  Future<List<int>> insertDays({
    required int programId,
    required List<String> dayNames,
  }) async {
    final ids = <int>[];
    for (var i = 0; i < dayNames.length; i++) {
      final id = await into(programDays).insert(
        ProgramDaysCompanion.insert(
          programId: programId,
          name: dayNames[i],
          dayOrder: i,
        ),
      );
      ids.add(id);
    }
    return ids;
  }

  // ──────────── Program Exercises ────────────

  /// Stream dos exercícios de um dia, incluindo nome do exercício, ordenados.
  Stream<List<domain.ProgramExercise>> watchExercisesForDay(int dayId) {
    final query =
        select(programExercises).join([
            innerJoin(
              exercises,
              exercises.id.equalsExp(programExercises.exerciseId),
            ),
          ])
          ..where(programExercises.programDayId.equals(dayId))
          ..orderBy([OrderingTerm.asc(programExercises.exerciseOrder)]);

    return query.watch().map(
      (rows) => rows.map((row) {
        final pe = row.readTable(programExercises);
        final ex = row.readTable(exercises);
        return _exerciseToDomain(pe, ex);
      }).toList(),
    );
  }

  /// Busca exercícios de um dia.
  Future<List<domain.ProgramExercise>> getExercisesForDay(int dayId) async {
    final query =
        select(programExercises).join([
            innerJoin(
              exercises,
              exercises.id.equalsExp(programExercises.exerciseId),
            ),
          ])
          ..where(programExercises.programDayId.equals(dayId))
          ..orderBy([OrderingTerm.asc(programExercises.exerciseOrder)]);

    final rows = await query.get();
    return rows.map((row) {
      final pe = row.readTable(programExercises);
      final ex = row.readTable(exercises);
      return _exerciseToDomain(pe, ex);
    }).toList();
  }

  /// Adiciona um exercício ao dia.
  Future<int> addExerciseToDay({
    required int programDayId,
    required int exerciseId,
    required int exerciseOrder,
    required int sets,
    required int repMin,
    required int repMax,
    int? rpeTarget,
    int restSeconds = 90,
  }) {
    return into(programExercises).insert(
      ProgramExercisesCompanion.insert(
        programDayId: programDayId,
        exerciseId: exerciseId,
        exerciseOrder: exerciseOrder,
        sets: sets,
        repMin: repMin,
        repMax: repMax,
        rpeTarget: Value(rpeTarget),
        restSeconds: Value(restSeconds),
      ),
    );
  }

  /// Atualiza a configuração de um exercício no programa.
  Future<void> updateProgramExercise({
    required int id,
    required int sets,
    required int repMin,
    required int repMax,
    int? rpeTarget,
    required int restSeconds,
  }) {
    return (update(programExercises)..where((pe) => pe.id.equals(id))).write(
      ProgramExercisesCompanion(
        sets: Value(sets),
        repMin: Value(repMin),
        repMax: Value(repMax),
        rpeTarget: Value(rpeTarget),
        restSeconds: Value(restSeconds),
      ),
    );
  }

  /// Remove um exercício de um dia.
  Future<void> removeExerciseFromDay(int programExerciseId) {
    return (delete(
      programExercises,
    )..where((pe) => pe.id.equals(programExerciseId))).go();
  }

  /// Reordena exercícios de um dia.
  Future<void> reorderExercises(List<domain.ProgramExercise> ordered) async {
    await transaction(() async {
      for (var i = 0; i < ordered.length; i++) {
        await (update(programExercises)
              ..where((pe) => pe.id.equals(ordered[i].id)))
            .write(ProgramExercisesCompanion(exerciseOrder: Value(i)));
      }
    });
  }

  /// Conta exercícios em um dia.
  Future<int> countExercisesInDay(int dayId) async {
    final query = selectOnly(programExercises)
      ..addColumns([programExercises.id.count()])
      ..where(programExercises.programDayId.equals(dayId));
    final result = await query.getSingle();
    return result.read(programExercises.id.count()) ?? 0;
  }
}
