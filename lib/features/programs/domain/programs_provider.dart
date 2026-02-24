import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../data/programs_dao.dart';
import '../domain/program.dart';
import '../domain/program_day.dart';
import '../domain/program_exercise.dart';

/// Provider do DAO de programas.
final programsDaoProvider = Provider<ProgramsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.programsDao;
});

/// Stream de todos os programas.
final programsProvider = StreamProvider<List<Program>>((ref) {
  final dao = ref.watch(programsDaoProvider);
  return dao.watchAll();
});

/// Stream do programa ativo.
final activeProgramProvider = StreamProvider<Program?>((ref) {
  final dao = ref.watch(programsDaoProvider);
  return dao.watchActive();
});

/// Stream de um programa específico por id.
final programByIdProvider = StreamProvider.family<Program?, int>((ref, id) {
  final dao = ref.watch(programsDaoProvider);
  return dao.watchById(id);
});

/// Stream dos dias de um programa.
final programDaysProvider = StreamProvider.family<List<ProgramDay>, int>((
  ref,
  programId,
) {
  final dao = ref.watch(programsDaoProvider);
  return dao.watchDays(programId);
});

/// Stream dos exercícios de um dia do programa.
final programDayExercisesProvider =
    StreamProvider.family<List<ProgramExercise>, int>((ref, dayId) {
      final dao = ref.watch(programsDaoProvider);
      return dao.watchExercisesForDay(dayId);
    });
