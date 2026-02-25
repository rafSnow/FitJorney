import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/extensions/double_ext.dart';
import '../../../shared/widgets/empty_state.dart';
import '../domain/progress_provider.dart';
import 'widgets/load_chart_widget.dart';

/// Tela de progresso — gráficos, streak semanal e volume por grupo muscular.
class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.progress)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(weeklyStreakProvider);
          ref.invalidate(weeklyVolumeProvider);
          ref.invalidate(loadHistoryProvider);
          ref.invalidate(exercisesWithLoadDataProvider);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          children: const [
            _WeeklyStreakSection(),
            SizedBox(height: AppSpacing.lg),
            _LoadEvolutionSection(),
            SizedBox(height: AppSpacing.lg),
            _WeeklyVolumeSection(),
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

// ─────────────── Streak Semanal ───────────────

class _WeeklyStreakSection extends ConsumerWidget {
  const _WeeklyStreakSection();

  static const _weekDays = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(weeklyStreakProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.weeklyStreak,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          streakAsync.when(
            loading: () => const SizedBox(
              height: 56,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
            data: (streak) {
              final trainedCount = streak.where((s) => s).length;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(7, (i) {
                      final trained = streak[i];
                      return Column(
                        children: [
                          Text(
                            _weekDays[i],
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: trained
                                  ? AppColors.primary
                                  : theme.colorScheme.surfaceContainerHighest,
                              border: trained
                                  ? null
                                  : Border.all(
                                      color: theme.colorScheme.outlineVariant,
                                    ),
                            ),
                            child: Center(
                              child: trained
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '$trainedCount/7 ${AppStrings.trained}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: trainedCount > 0
                          ? AppColors.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: trainedCount > 0
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────── Evolução de Carga ───────────────

class _LoadEvolutionSection extends ConsumerWidget {
  const _LoadEvolutionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesWithLoadDataProvider);
    final selectedExercise = ref.watch(selectedExerciseProvider);
    final loadHistoryAsync = ref.watch(loadHistoryProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.loadEvolution,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Selector de exercício (3.2.2)
          exercisesAsync.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const SizedBox.shrink(),
            data: (exercises) {
              if (exercises.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  child: EmptyState(
                    icon: Icons.show_chart,
                    title: AppStrings.noProgress,
                    message: AppStrings.noProgressCta,
                  ),
                );
              }

              // Auto-selecionar primeiro exercício se nenhum selecionado
              if (selectedExercise == null ||
                  !exercises.any((e) => e.id == selectedExercise.id)) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(selectedExerciseProvider.notifier).state =
                      exercises.first;
                });
              }

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value:
                        selectedExercise != null &&
                            exercises.any((e) => e.id == selectedExercise.id)
                        ? selectedExercise.id
                        : null,
                    isExpanded: true,
                    hint: Text(AppStrings.selectExerciseToView),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: exercises.map((ex) {
                      return DropdownMenuItem<int>(
                        value: ex.id,
                        child: Text(ex.name, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (id) {
                      if (id == null) return;
                      final ex = exercises.firstWhere((e) => e.id == id);
                      ref.read(selectedExerciseProvider.notifier).state = ex;
                    },
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: AppSpacing.md),

          // Gráfico de linha (3.2.3)
          if (selectedExercise != null)
            loadHistoryAsync.when(
              loading: () => const SizedBox(
                height: 220,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (data) {
                if (data.isEmpty) {
                  return SizedBox(
                    height: 160,
                    child: Center(
                      child: Text(
                        AppStrings.noExerciseData,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                }
                return LoadChartWidget(dataPoints: data);
              },
            ),

          const SizedBox(height: AppSpacing.md),

          // Tabela de histórico (3.2.4)
          if (selectedExercise != null)
            loadHistoryAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (data) {
                if (data.isEmpty) return const SizedBox.shrink();
                return _LoadHistoryTable(dataPoints: data);
              },
            ),
        ],
      ),
    );
  }
}

// ─────────────── Tabela de Histórico ───────────────

class _LoadHistoryTable extends StatelessWidget {
  const _LoadHistoryTable({required this.dataPoints});

  final List<LoadDataPoint> dataPoints;

  static const _months = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Mostrar os últimos registros primeiro (mais recente em cima)
    final reversed = dataPoints.reversed.toList();
    // Limitar a 20 registros na tabela
    final limited = reversed.take(20).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.loadHistory,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            child: Column(
              children: [
                // Cabeçalho
                Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          AppStrings.date,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          AppStrings.maxLoad,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          AppStrings.repsCompleted,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                // Linhas
                ...limited.asMap().entries.map((entry) {
                  final i = entry.key;
                  final dp = entry.value;
                  final dateStr =
                      '${dp.date.day} ${_months[dp.date.month - 1]} ${dp.date.year}';

                  // Mostrar mudança de carga em relação ao anterior
                  final isFirst = i == limited.length - 1;
                  final prevLoad = isFirst ? null : limited[i + 1].maxLoad;
                  final loadDelta = prevLoad != null
                      ? dp.maxLoad - prevLoad
                      : null;

                  return Container(
                    decoration: BoxDecoration(
                      border: i < limited.length - 1
                          ? Border(
                              bottom: BorderSide(
                                color: theme.colorScheme.outlineVariant
                                    .withValues(alpha: 0.5),
                              ),
                            )
                          : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            dateStr,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                dp.maxLoad.toKgString(),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (loadDelta != null && loadDelta != 0) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  loadDelta > 0
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 12,
                                  color: loadDelta > 0
                                      ? AppColors.success
                                      : AppColors.error,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${dp.reps}',
                            style: theme.textTheme.bodySmall,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────── Volume Semanal ───────────────

class _WeeklyVolumeSection extends ConsumerWidget {
  const _WeeklyVolumeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final volumeAsync = ref.watch(weeklyVolumeProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.weeklyVolume,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          volumeAsync.when(
            loading: () => const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
            data: (volumes) {
              if (volumes.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Text(
                    AppStrings.noProgressCta,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              }

              final maxSets = volumes
                  .map((v) => v.totalSets)
                  .reduce((a, b) => a > b ? a : b);

              return Column(
                children: volumes.map((v) {
                  final ratio = maxSets > 0 ? v.totalSets / maxSets : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            v.label,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: ratio,
                              minHeight: 20,
                              backgroundColor:
                                  theme.colorScheme.surfaceContainerHighest,
                              color: AppColors.primary.withValues(
                                alpha: 0.6 + (ratio * 0.4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        SizedBox(
                          width: 50,
                          child: Text(
                            '${v.totalSets} ${AppStrings.totalSets}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
