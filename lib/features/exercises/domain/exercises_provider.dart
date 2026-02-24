import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../data/exercises_dao.dart';
import '../domain/exercise.dart';

/// Provider do DAO de exercícios.
final exercisesDaoProvider = Provider<ExercisesDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.exercisesDao;
});

/// Stream de todos os exercícios ativos.
final exercisesProvider = StreamProvider<List<Exercise>>((ref) {
  final dao = ref.watch(exercisesDaoProvider);
  return dao.watchAll();
});

/// Stream de um exercício específico por id.
final exerciseByIdProvider = StreamProvider.family<Exercise?, int>((ref, id) {
  final dao = ref.watch(exercisesDaoProvider);
  return dao.watchById(id);
});

/// Stream de exercícios filtrados por busca.
final exerciseSearchProvider = StreamProvider.family<List<Exercise>, String>((
  ref,
  searchTerm,
) {
  final dao = ref.watch(exercisesDaoProvider);
  if (searchTerm.isEmpty) {
    return dao.watchAll();
  }
  return dao.watchByName(searchTerm);
});
