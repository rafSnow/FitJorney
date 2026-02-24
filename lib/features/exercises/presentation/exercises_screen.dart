import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../domain/exercises_provider.dart';
import 'widgets/exercise_card.dart';

/// Tela de exercícios — lista com busca e EmptyState.
class ExercisesScreen extends ConsumerStatefulWidget {
  const ExercisesScreen({super.key});

  @override
  ConsumerState<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends ConsumerState<ExercisesScreen> {
  final _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = _searchTerm.isEmpty
        ? ref.watch(exercisesProvider)
        : ref.watch(exerciseSearchProvider(_searchTerm));

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.exercises)),
      body: Column(
        children: [
          // Barra de busca
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppStrings.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchTerm.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchTerm = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() => _searchTerm = value.trim());
              },
            ),
          ),
          // Lista
          Expanded(
            child: exercisesAsync.when(
              loading: () => const LoadingOverlay(
                isLoading: true,
                child: SizedBox.expand(),
              ),
              error: (error, _) =>
                  Center(child: Text('${AppStrings.genericError}\n$error')),
              data: (exercises) {
                if (exercises.isEmpty) {
                  return EmptyState(
                    icon: Icons.fitness_center,
                    title: AppStrings.noExercises,
                    message: AppStrings.noExercisesCta,
                    actionLabel: AppStrings.newExercise,
                    onAction: () => context.push('/exercises/new'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return ExerciseCard(
                      exercise: exercise,
                      onTap: () => context.push('/exercises/${exercise.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/exercises/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
