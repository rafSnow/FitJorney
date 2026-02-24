import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/fj_button.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../domain/program.dart';
import '../domain/program_day.dart';
import '../domain/program_exercise.dart';
import '../domain/programs_provider.dart';
import 'widgets/exercise_config_bottom_sheet.dart';
import 'widgets/exercise_config_tile.dart';
import 'widgets/exercise_select_bottom_sheet.dart';

/// Tela de detalhes de um programa.
///
/// Exibe todos os dias e exercícios.
/// Permite: adicionar exercício, configurar, reordenar, ativar programa.
class ProgramDetailScreen extends ConsumerWidget {
  const ProgramDetailScreen({super.key, required this.programId});

  final int programId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programAsync = ref.watch(programByIdProvider(programId));
    final daysAsync = ref.watch(programDaysProvider(programId));

    return programAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('${AppStrings.genericError}\n$e')),
      ),
      data: (program) {
        if (program == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Programa não encontrado')),
          );
        }
        return _ProgramDetailView(
          program: program,
          daysAsync: daysAsync,
        );
      },
    );
  }
}

class _ProgramDetailView extends ConsumerWidget {
  const _ProgramDetailView({
    required this.program,
    required this.daysAsync,
  });

  final Program program;
  final AsyncValue<List<ProgramDay>> daysAsync;

  Future<void> _activate(BuildContext context, WidgetRef ref) async {
    final dao = ref.read(programsDaoProvider);
    await dao.activateProgram(program.id);
    HapticFeedback.lightImpact();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${program.name}" ${AppStrings.programActivated}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _deleteProgram(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.deleteProgramTitle),
        content: const Text(AppStrings.deleteProgramMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final dao = ref.read(programsDaoProvider);
    await dao.deleteProgram(program.id);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(program.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: AppStrings.editProgram,
            onPressed: () =>
                context.push('/programs/${program.id}/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: AppStrings.deleteProgramTitle,
            color: theme.colorScheme.error,
            onPressed: () => _deleteProgram(context, ref),
          ),
        ],
      ),
      body: Stack(
        children: [
          daysAsync.when(
            loading: () =>
                const LoadingOverlay(isLoading: true, child: SizedBox.expand()),
            error: (e, _) =>
                Center(child: Text('${AppStrings.genericError}\n$e')),
            data: (days) {
              if (days.isEmpty) {
                return EmptyState(
                  icon: Icons.calendar_today_outlined,
                  title: 'Nenhum dia configurado',
                  message: 'Edite o programa para adicionar dias.',
                  actionLabel: AppStrings.editProgram,
                  onAction: () =>
                      context.push('/programs/${program.id}/edit'),
                );
              }
              return ListView.builder(
                // Padding bottom para o botão flutuante não cobrir conteúdo
                padding: EdgeInsets.only(
                  bottom: program.isActive ? AppSpacing.xl : 88,
                ),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  return _DaySection(
                    day: days[index],
                    programId: program.id,
                  );
                },
              );
            },
          ),
          // Botão ativar no terço inferior (só se não ativo)
          if (!program.isActive)
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: FJButton(
                label: AppStrings.activate,
                icon: Icons.star_outline,
                onPressed: () => _activate(context, ref),
              ),
            ),
        ],
      ),
    );
  }
}

/// Seção que representa um dia do programa com lista reordenável de exercícios.
class _DaySection extends ConsumerWidget {
  const _DaySection({required this.day, required this.programId});

  final ProgramDay day;
  final int programId;

  Future<void> _addExercise(BuildContext context, WidgetRef ref) async {
    final exercise = await showExerciseSelectBottomSheet(context);
    if (exercise == null || !context.mounted) return;

    final config = await showExerciseConfigBottomSheet(
      context,
      exerciseName: exercise.name,
    );
    if (config == null || !context.mounted) return;

    final dao = ref.read(programsDaoProvider);
    final current = await dao.getExercisesForDay(day.id);
    await dao.addExerciseToDay(
      programDayId: day.id,
      exerciseId: exercise.id,
      exerciseOrder: current.length,
      sets: config.sets,
      repMin: config.repMin,
      repMax: config.repMax,
      rpeTarget: config.rpeTarget,
      restSeconds: config.restSeconds,
    );
    HapticFeedback.lightImpact();
  }

  Future<void> _editExercise(
    BuildContext context,
    WidgetRef ref,
    ProgramExercise pe,
  ) async {
    final config = await showExerciseConfigBottomSheet(
      context,
      exerciseName: pe.exerciseName,
      existing: pe,
    );
    if (config == null || !context.mounted) return;

    final dao = ref.read(programsDaoProvider);
    await dao.updateProgramExercise(
      id: pe.id,
      sets: config.sets,
      repMin: config.repMin,
      repMax: config.repMax,
      rpeTarget: config.rpeTarget,
      restSeconds: config.restSeconds,
    );
    HapticFeedback.lightImpact();
  }

  Future<void> _removeExercise(
    BuildContext context,
    WidgetRef ref,
    ProgramExercise pe,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remover exercício?'),
        content: Text(
          'Remover "${pe.exerciseName ?? 'exercício'}" deste dia do programa?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final dao = ref.read(programsDaoProvider);
    await dao.removeExerciseFromDay(pe.id);
    HapticFeedback.lightImpact();
  }

  Future<void> _reorder(
    WidgetRef ref,
    List<ProgramExercise> exercises,
    int oldIndex,
    int newIndex,
  ) async {
    if (newIndex > oldIndex) newIndex--;
    final reordered = [...exercises];
    final item = reordered.removeAt(oldIndex);
    reordered.insert(newIndex, item);
    final dao = ref.read(programsDaoProvider);
    await dao.reorderExercises(reordered);
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final exercisesAsync = ref.watch(programDayExercisesProvider(day.id));

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header do dia
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.dayOrder + 1}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    day.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _addExercise(context, ref),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(AppStrings.add),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),

          // Lista de exercícios (reordenável)
          exercisesAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(AppStrings.genericError),
            ),
            data: (exercises) {
              if (exercises.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: Text(
                    'Nenhum exercício. Toque em + para adicionar.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }
              // ReorderableListView shrinkWrap para caber dentro do Card
              return ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: (oldIndex, newIndex) =>
                    _reorder(ref, exercises, oldIndex, newIndex),
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final pe = exercises[index];
                  return ExerciseConfigTile(
                    key: ValueKey(pe.id),
                    programExercise: pe,
                    onTap: () => _editExercise(context, ref, pe),
                    onDelete: () => _removeExercise(context, ref, pe),
                    reorderHandle: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(
                        Icons.drag_handle,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}
