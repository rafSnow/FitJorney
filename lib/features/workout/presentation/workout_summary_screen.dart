import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/fj_button.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../programs/domain/program_exercise.dart';
import '../domain/progression_engine.dart';
import '../domain/set_record.dart';
import '../domain/workout_provider.dart';
import '../domain/workout_state.dart';
import 'progression_badge_widget.dart';
import 'progression_confirm_dialog.dart';

// Provider local para análise de progressão do resumo
final _summaryProgressionProvider = FutureProvider.autoDispose
    .family<Map<int, ProgressionResult>, WorkoutState>((ref, workout) async {
      final dao = ref.read(workoutDaoProvider);
      final results = <int, ProgressionResult>{};

      for (final ex in workout.exercises) {
        final currentSets = workout.setsForExercise(ex.id);
        if (currentSets.isEmpty) continue;

        final previousSets = await dao.getLastCompletedSetsForProgramExercise(
          ex.id,
        );
        final currentLoad = workout.lastLoadFor(ex.id);

        // Busca incremento real com base na classificação do exercício
        final details = await dao.getExerciseDetailsForProgression(ex.id);
        double increment = 2.5; // fallback
        if (details != null) {
          increment = details.customIncrement ??
              ProgressionConstants.getSuggestedIncrement(
                details.muscleSize == 'large'
                    ? MuscleSize.large
                    : MuscleSize.small,
                details.exerciseType == 'compound'
                    ? ExerciseType.compound
                    : ExerciseType.isolation,
              );
        }

        results[ex.id] = ProgressionEngine.analyze(
          sets: currentSets,
          repMin: ex.repMin,
          repMax: ex.repMax,
          currentLoad: currentLoad,
          increment: increment,
          previousSessionSets: previousSets,
        );
      }

      return results;
    });

/// Tela de resumo pós-treino — mostra séries e análise de progressão.
class WorkoutSummaryScreen extends ConsumerWidget {
  const WorkoutSummaryScreen({super.key});

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '${h}h ${m}min' : '${m}min ${s}s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutAsync = ref.watch(activeWorkoutProvider);

    return workoutAsync.when(
      loading: () => const Scaffold(
        body: LoadingOverlay(isLoading: true, child: SizedBox.expand()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.workoutSummary)),
        body: Center(child: Text('${AppStrings.genericError}\n$e')),
      ),
      data: (workout) {
        if (workout == null) {
          // Sem dado — leva para home
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/');
          });
          return const Scaffold(
            body: LoadingOverlay(isLoading: true, child: SizedBox.expand()),
          );
        }
        return _SummaryContent(
          workout: workout,
          formatDuration: _formatDuration,
        );
      },
    );
  }
}

class _SummaryContent extends ConsumerWidget {
  const _SummaryContent({required this.workout, required this.formatDuration});

  final WorkoutState workout;
  final String Function(Duration) formatDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressionAsync = ref.watch(_summaryProgressionProvider(workout));
    final progressions = progressionAsync.valueOrNull ?? {};

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.workoutSummary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // ── Header: duração e nome do dia ──
          _SummaryHeader(
            dayName: workout.dayName,
            duration: formatDuration(workout.session.elapsed),
            totalExercises: workout.exercises.length,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Exercícios ──
          ...workout.exercises.map((ex) {
            final sets = workout.setsForExercise(ex.id);
            final progression = progressions[ex.id];
            return _ExerciseSummaryCard(
              exercise: ex,
              sets: sets,
              progression: progression,
              currentLoad: workout.lastLoadFor(ex.id),
            );
          }),

          const SizedBox(height: AppSpacing.lg),

          // ── Concluir ──
          FJButton(
            label: 'Concluir',
            icon: Icons.home_outlined,
            onPressed: () {
              HapticFeedback.heavyImpact();
              ref.read(activeWorkoutProvider.notifier).resetAfterSummary();
              context.go('/');
            },
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

// ─────────────── Header ───────────────

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({
    required this.dayName,
    required this.duration,
    required this.totalExercises,
  });

  final String dayName;
  final String duration;
  final int totalExercises;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.15),
            AppColors.primaryLight.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 48),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Treino concluído!',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            dayName,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                icon: Icons.timer_outlined,
                label: 'Duração',
                value: duration,
              ),
              _StatItem(
                icon: Icons.fitness_center,
                label: 'Exercícios',
                value: '$totalExercises',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ─────────────── Card por exercício ───────────────

class _ExerciseSummaryCard extends ConsumerWidget {
  const _ExerciseSummaryCard({
    required this.exercise,
    required this.sets,
    required this.currentLoad,
    this.progression,
  });

  final ProgramExercise exercise;
  final List<SetRecord> sets;
  final double currentLoad;
  final ProgressionResult? progression;

  Future<void> _handleProgressionTap(BuildContext context, WidgetRef ref) async {
    if (progression == null || !progression!.hasAction) return;

    final confirmedLoad = await showProgressionConfirmDialog(
      context: context,
      exerciseName: exercise.exerciseName ?? 'Exercício',
      currentLoad: currentLoad,
      suggestedLoad: progression!.suggestedNewLoad ?? currentLoad,
      isIncrease: progression!.shouldIncreaseLoad,
    );

    if (confirmedLoad != null) {
      final dao = ref.read(workoutDaoProvider);
      await dao.updateNextSuggestedLoad(exercise.id, confirmedLoad);
      if (context.mounted) {
        HapticFeedback.mediumImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Carga de ${confirmedLoad.toStringAsFixed(confirmedLoad % 1 == 0 ? 0 : 1)} kg salva para a próxima sessão',
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final doneSets = sets.where((s) => !s.wasSkipped).length;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome do exercício
            Row(
              children: [
                Expanded(
                  child: Text(
                    exercise.exerciseName ?? 'Exercício',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$doneSets/${exercise.sets} séries',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: doneSets >= exercise.sets
                        ? AppColors.success
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            if (sets.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              // Lista de séries
              ...sets.where((s) => !s.wasSkipped).map((s) {
                final parts = <String>[];
                if (s.loadKg != null) {
                  parts.add(
                    '${s.loadKg!.toStringAsFixed(s.loadKg! % 1 == 0 ? 0 : 1)} kg',
                  );
                }
                if (s.repsCompleted != null) {
                  parts.add('${s.repsCompleted} reps');
                }
                if (s.rpeAchieved != null) parts.add('RPE ${s.rpeAchieved}');

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        'S${s.setNumber}${s.isExtra ? " +" : ""}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          parts.join(' · '),
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      if (s.rpeAchieved != null)
                        Container(
                          width: 28,
                          height: 18,
                          decoration: BoxDecoration(
                            color: AppColors.colorForRpe(
                              s.rpeAchieved!,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${s.rpeAchieved}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AppColors.colorForRpe(s.rpeAchieved!),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],

            // Banner de progressão
            if (progression != null && progression!.hasAction) ...[
              const SizedBox(height: AppSpacing.sm),
              ProgressionBadgeWidget(
                result: progression!,
                currentLoad: currentLoad,
                onTap: () => _handleProgressionTap(context, ref),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


