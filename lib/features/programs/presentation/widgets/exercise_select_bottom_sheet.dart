import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../exercises/domain/exercise.dart';
import '../../../exercises/domain/exercises_provider.dart';
import '../../../exercises/presentation/widgets/exercise_card.dart';

/// Bottom sheet para selecionar um exercício e adicioná-lo a um dia do programa.
///
/// Retorna o [Exercise] selecionado ou null se cancelado.
Future<Exercise?> showExerciseSelectBottomSheet(
  BuildContext context,
) {
  return showModalBottomSheet<Exercise>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => const _ExerciseSelectSheet(),
  );
}

class _ExerciseSelectSheet extends ConsumerStatefulWidget {
  const _ExerciseSelectSheet();

  @override
  ConsumerState<_ExerciseSelectSheet> createState() =>
      _ExerciseSelectSheetState();
}

class _ExerciseSelectSheetState extends ConsumerState<_ExerciseSelectSheet> {
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

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Column(
          children: [
            // Handle
            const _SheetHandle(),

            // Título
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Text(
                AppStrings.selectExercise,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Busca
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: TextField(
                controller: _searchController,
                autofocus: true,
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
                onChanged: (v) => setState(() => _searchTerm = v.trim()),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Lista
            Expanded(
              child: exercisesAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text('${AppStrings.genericError}\n$e'),
                ),
                data: (exercises) {
                  if (exercises.isEmpty) {
                    return EmptyState(
                      icon: Icons.fitness_center,
                      title: AppStrings.noExercises,
                      message: AppStrings.noExercisesCta,
                    );
                  }
                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = exercises[index];
                      return ExerciseCard(
                        exercise: exercise,
                        onTap: () => Navigator.of(context).pop(exercise),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
