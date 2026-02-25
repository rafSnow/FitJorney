import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../exercises/data/exercises_table.dart';
import '../../programs/data/program_days_table.dart';
import '../../programs/data/program_exercises_table.dart';
import '../../programs/data/programs_table.dart';
import '../../programs/domain/program_exercise.dart' as program_domain;
import '../domain/set_record.dart' as set_domain;
import '../domain/workout_session.dart' as session_domain;
import 'sessions_table.dart';
import 'set_records_table.dart';

part 'workout_dao.g.dart';

/// Dados de sessão enriquecidos para listagem do histórico.
typedef SessionWithInfo = ({
  int id,
  DateTime startedAt,
  DateTime? finishedAt,
  String dayName,
  String programName,
  int programDayId,
});

/// DAO de sessões de treino — CRUD completo com auto-save por série.
@DriftAccessor(
  tables: [
    WorkoutSessions,
    SetRecords,
    ProgramDays,
    ProgramExercises,
    Exercises,
    Programs,
  ],
)
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  WorkoutDao(super.db);

  // ─────────────── Conversões ───────────────

  session_domain.WorkoutSession _sessionToDomain(WorkoutSession row) {
    return session_domain.WorkoutSession(
      id: row.id,
      programDayId: row.programDayId,
      startedAt: row.startedAt,
      finishedAt: row.finishedAt,
      status: row.status,
    );
  }

  set_domain.SetRecord _setToDomain(SetRecord row) {
    return set_domain.SetRecord(
      id: row.id,
      sessionId: row.sessionId,
      programExerciseId: row.programExerciseId,
      setNumber: row.setNumber,
      loadKg: row.loadKg,
      timeSeconds: row.timeSeconds,
      repsCompleted: row.repsCompleted,
      rpeAchieved: row.rpeAchieved,
      recordedAt: row.recordedAt,
      isExtra: row.isExtra,
      wasSkipped: row.wasSkipped,
    );
  }

  program_domain.ProgramExercise _exerciseToDomain(
    ProgramExercise pe,
    Exercise ex,
  ) {
    return program_domain.ProgramExercise(
      id: pe.id,
      programDayId: pe.programDayId,
      exerciseId: pe.exerciseId,
      exerciseOrder: pe.exerciseOrder,
      sets: pe.sets,
      repMin: pe.repMin,
      repMax: pe.repMax,
      rpeTarget: pe.rpeTarget,
      restSeconds: pe.restSeconds,
      exerciseName: ex.name,
    );
  }

  // ─────────────── Sessões ───────────────

  /// Cria uma nova sessão com status in_progress.
  Future<int> createSession(int programDayId) {
    return into(workoutSessions).insert(
      WorkoutSessionsCompanion.insert(
        programDayId: programDayId,
        startedAt: DateTime.now(),
      ),
    );
  }

  /// Busca a sessão ativa (in_progress) mais recente.
  Future<session_domain.WorkoutSession?> getActiveSession() async {
    final query = select(workoutSessions)
      ..where((s) => s.status.equals('in_progress'))
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
      ..limit(1);
    final rows = await query.get();
    return rows.isNotEmpty ? _sessionToDomain(rows.first) : null;
  }

  /// Busca sessão por id.
  Future<session_domain.WorkoutSession?> getSessionById(int id) async {
    final query = select(workoutSessions)..where((s) => s.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _sessionToDomain(row) : null;
  }

  /// Marca sessão como concluída.
  Future<void> completeSession(int sessionId) {
    return (update(
      workoutSessions,
    )..where((s) => s.id.equals(sessionId))).write(
      WorkoutSessionsCompanion(
        status: const Value('completed'),
        finishedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Marca sessão como cancelada.
  Future<void> cancelSession(int sessionId) {
    return (update(workoutSessions)..where((s) => s.id.equals(sessionId)))
        .write(const WorkoutSessionsCompanion(status: Value('cancelled')));
  }

  /// Stream de sessões concluídas, mais recentes primeiro.
  Stream<List<session_domain.WorkoutSession>> watchCompletedSessions() {
    final query = select(workoutSessions)
      ..where((s) => s.status.equals('completed'))
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]);
    return query.watch().map((rows) => rows.map(_sessionToDomain).toList());
  }

  /// Busca a última sessão concluída para um programa específico.
  /// Útil para determinar o próximo dia a treinar.
  Future<session_domain.WorkoutSession?> getLastCompletedSessionForProgram(
    int programId,
  ) async {
    final query =
        select(workoutSessions).join([
            innerJoin(
              programDays,
              programDays.id.equalsExp(workoutSessions.programDayId),
            ),
          ])
          ..where(
            workoutSessions.status.equals('completed') &
                programDays.programId.equals(programId),
          )
          ..orderBy([OrderingTerm.desc(workoutSessions.startedAt)])
          ..limit(1);
    final rows = await query.get();
    if (rows.isEmpty) return null;
    return _sessionToDomain(rows.first.readTable(workoutSessions));
  }

  // ─────────────── Séries (auto-save) ───────────────

  /// Salva ou atualiza uma série. Chame a cada confirmação — nunca perde dados.
  Future<int> saveSet({
    required int sessionId,
    required int programExerciseId,
    required int setNumber,
    double? loadKg,
    int? timeSeconds,
    int? repsCompleted,
    int? rpeAchieved,
    bool isExtra = false,
    bool wasSkipped = false,
  }) {
    return into(setRecords).insertOnConflictUpdate(
      SetRecordsCompanion.insert(
        sessionId: sessionId,
        programExerciseId: programExerciseId,
        setNumber: setNumber,
        loadKg: Value(loadKg),
        timeSeconds: Value(timeSeconds),
        repsCompleted: Value(repsCompleted),
        rpeAchieved: Value(rpeAchieved),
        isExtra: Value(isExtra),
        wasSkipped: Value(wasSkipped),
      ),
    );
  }

  /// Stream das séries de uma sessão, ordenadas por exercício e número da série.
  Stream<List<set_domain.SetRecord>> watchSetsForSession(int sessionId) {
    final query = select(setRecords)
      ..where((s) => s.sessionId.equals(sessionId))
      ..orderBy([
        (s) => OrderingTerm.asc(s.programExerciseId),
        (s) => OrderingTerm.asc(s.setNumber),
      ]);
    return query.watch().map((rows) => rows.map(_setToDomain).toList());
  }

  /// Busca todas as séries de uma sessão.
  Future<List<set_domain.SetRecord>> getSetsForSession(int sessionId) async {
    final query = select(setRecords)
      ..where((s) => s.sessionId.equals(sessionId))
      ..orderBy([
        (s) => OrderingTerm.asc(s.programExerciseId),
        (s) => OrderingTerm.asc(s.setNumber),
      ]);
    final rows = await query.get();
    return rows.map(_setToDomain).toList();
  }

  // ─────────────── Histórico para pre-fill ───────────────

  /// Busca a última carga usada para um exercício do programa.
  /// Retorna null se nunca foi registrado.
  Future<double?> getLastLoadForProgramExercise(int programExerciseId) async {
    final query = select(setRecords)
      ..where(
        (s) =>
            s.programExerciseId.equals(programExerciseId) &
            s.wasSkipped.equals(false) &
            s.loadKg.isNotNull(),
      )
      ..orderBy([(s) => OrderingTerm.desc(s.recordedAt)])
      ..limit(1);
    final rows = await query.get();
    return rows.isNotEmpty ? rows.first.loadKg : null;
  }

  /// Busca todas as séries da última sessão concluída para análise de progressão.
  Future<List<set_domain.SetRecord>> getLastCompletedSetsForProgramExercise(
    int programExerciseId,
  ) async {
    // Encontra o sessionId mais recente concluído que teve este exercício
    final subQ =
        select(setRecords).join([
            innerJoin(
              workoutSessions,
              workoutSessions.id.equalsExp(setRecords.sessionId),
            ),
          ])
          ..addColumns([setRecords.sessionId])
          ..where(
            setRecords.programExerciseId.equals(programExerciseId) &
                workoutSessions.status.equals('completed'),
          )
          ..orderBy([OrderingTerm.desc(workoutSessions.startedAt)])
          ..limit(1);

    final result = await subQ.getSingleOrNull();
    if (result == null) return [];
    final sessionId = result.read(setRecords.sessionId);
    if (sessionId == null) return [];

    final query = select(setRecords)
      ..where(
        (s) =>
            s.sessionId.equals(sessionId) &
            s.programExerciseId.equals(programExerciseId) &
            s.wasSkipped.equals(false),
      )
      ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]);
    final rows = await query.get();
    return rows.map(_setToDomain).toList();
  }

  // ─────────────── Exercícios do dia ───────────────

  /// Busca o nome de um dia do programa.
  Future<String> getDayName(int programDayId) async {
    final query = select(programDays)..where((d) => d.id.equals(programDayId));
    final row = await query.getSingleOrNull();
    return row?.name ?? '';
  }

  /// Busca os exercícios de um dia do programa (com nome do exercício).
  Future<List<program_domain.ProgramExercise>> getExercisesForDay(
    int programDayId,
  ) async {
    final query =
        select(programExercises).join([
            innerJoin(
              exercises,
              exercises.id.equalsExp(programExercises.exerciseId),
            ),
          ])
          ..where(programExercises.programDayId.equals(programDayId))
          ..orderBy([OrderingTerm.asc(programExercises.exerciseOrder)]);
    final rows = await query.get();
    return rows
        .map(
          (row) => _exerciseToDomain(
            row.readTable(programExercises),
            row.readTable(exercises),
          ),
        )
        .toList();
  }

  /// Busca o exercício completo (com detalhes para progressão) pelo programExerciseId.
  Future<program_domain.ProgramExercise?> getProgramExerciseWithDetails(
    int programExerciseId,
  ) async {
    final query = select(programExercises).join([
      innerJoin(exercises, exercises.id.equalsExp(programExercises.exerciseId)),
    ])..where(programExercises.id.equals(programExerciseId));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return _exerciseToDomain(
      row.readTable(programExercises),
      row.readTable(exercises),
    );
  }

  // ─────────────── Progressão: next suggested load ───────────────

  /// Busca a carga sugerida para a próxima sessão de um exercício do programa.
  Future<double?> getNextSuggestedLoad(int programExerciseId) async {
    final query = selectOnly(programExercises)
      ..addColumns([programExercises.nextSuggestedLoad])
      ..where(programExercises.id.equals(programExerciseId));
    final row = await query.getSingleOrNull();
    return row?.read(programExercises.nextSuggestedLoad);
  }

  /// Persiste a carga sugerida para a próxima sessão.
  /// Chamar com `null` para limpar a sugestão.
  Future<void> updateNextSuggestedLoad(int programExerciseId, double? load) {
    return (update(programExercises)
          ..where((pe) => pe.id.equals(programExerciseId)))
        .write(ProgramExercisesCompanion(nextSuggestedLoad: Value(load)));
  }

  /// Busca os detalhes do exercício (muscleSize, exerciseType, customIncrement)
  /// a partir do programExerciseId.
  Future<({String muscleSize, String exerciseType, double? customIncrement})?>
  getExerciseDetailsForProgression(int programExerciseId) async {
    final query = select(programExercises).join([
      innerJoin(exercises, exercises.id.equalsExp(programExercises.exerciseId)),
    ])..where(programExercises.id.equals(programExerciseId));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    final ex = row.readTable(exercises);
    return (
      muscleSize: ex.muscleSize,
      exerciseType: ex.exerciseType,
      customIncrement: ex.customIncrement,
    );
  }

  // ─────────────── Histórico enriquecido ───────────────

  /// Stream de sessões concluídas com nome do dia e do programa.
  Stream<List<SessionWithInfo>> watchCompletedSessionsWithInfo() {
    final query =
        select(workoutSessions).join([
            innerJoin(
              programDays,
              programDays.id.equalsExp(workoutSessions.programDayId),
            ),
            innerJoin(programs, programs.id.equalsExp(programDays.programId)),
          ])
          ..where(workoutSessions.status.equals('completed'))
          ..orderBy([OrderingTerm.desc(workoutSessions.startedAt)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final session = row.readTable(workoutSessions);
        final day = row.readTable(programDays);
        final program = row.readTable(programs);
        return (
          id: session.id,
          startedAt: session.startedAt,
          finishedAt: session.finishedAt,
          dayName: day.name,
          programName: program.name,
          programDayId: session.programDayId,
        );
      }).toList();
    });
  }

  /// Busca o nome do programa a partir de um programDayId.
  Future<String> getProgramNameForDay(int programDayId) async {
    final query = select(programDays).join([
      innerJoin(programs, programs.id.equalsExp(programDays.programId)),
    ])..where(programDays.id.equals(programDayId));
    final row = await query.getSingleOrNull();
    if (row == null) return '';
    return row.readTable(programs).name;
  }

  /// Busca as séries da sessão imediatamente anterior para um exercício.
  /// Usado para análise de progressão em sessões históricas.
  Future<List<set_domain.SetRecord>> getPreviousSetsForExercise(
    int sessionId,
    int programExerciseId,
  ) async {
    // Busca o horário de início da sessão atual
    final currentQuery = select(workoutSessions)
      ..where((s) => s.id.equals(sessionId));
    final currentSession = await currentQuery.getSingleOrNull();
    if (currentSession == null) return [];

    // Encontra o sessionId da sessão concluída anterior que tenha esse exercício
    final prevQuery =
        select(setRecords).join([
            innerJoin(
              workoutSessions,
              workoutSessions.id.equalsExp(setRecords.sessionId),
            ),
          ])
          ..where(
            setRecords.programExerciseId.equals(programExerciseId) &
                workoutSessions.status.equals('completed') &
                workoutSessions.startedAt.isSmallerThanValue(
                  currentSession.startedAt,
                ),
          )
          ..orderBy([OrderingTerm.desc(workoutSessions.startedAt)])
          ..limit(1);

    final prevResult = await prevQuery.getSingleOrNull();
    if (prevResult == null) return [];
    final prevSessionId = prevResult.read(setRecords.sessionId);
    if (prevSessionId == null) return [];

    // Busca todas as séries não-puladas daquela sessão para este exercício
    final setsQuery = select(setRecords)
      ..where(
        (s) =>
            s.sessionId.equals(prevSessionId) &
            s.programExerciseId.equals(programExerciseId) &
            s.wasSkipped.equals(false),
      )
      ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]);

    final rows = await setsQuery.get();
    return rows.map(_setToDomain).toList();
  }
}
