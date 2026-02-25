import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../workout/domain/set_record.dart';
import '../../workout/presentation/progression_badge_widget.dart';
import '../domain/history_provider.dart';

/// Meses abreviados em pt-BR.
const _months = [
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

/// Tela de detalhes de uma sessão — exercícios, séries, cargas, RPEs.
class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.sessionId});

  final int sessionId;

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}min';
    return '${m}min ${s.toString().padLeft(2, '0')}s';
  }

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = _months[dt.month - 1];
    final year = dt.year;
    final weekday = _weekdayName(dt.weekday);
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$weekday, $day $month $year · $hour:$minute';
  }

  String _weekdayName(int weekday) {
    return switch (weekday) {
      1 => 'Seg',
      2 => 'Ter',
      3 => 'Qua',
      4 => 'Qui',
      5 => 'Sex',
      6 => 'Sáb',
      7 => 'Dom',
      _ => '',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(sessionDetailProvider(sessionId));

    return detailAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.sessionDetail)),
        body: const LoadingOverlay(isLoading: true, child: SizedBox.expand()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.sessionDetail)),
        body: Center(child: Text('${AppStrings.genericError}\n$e')),
      ),
      data: (detail) {
        if (detail == null) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.sessionDetail)),
            body: const Center(child: Text(AppStrings.genericError)),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text(AppStrings.sessionDetail)),
          body: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              // ── Header ──
              _DetailHeader(
                dayName: detail.dayName,
                programName: detail.programName,
                date: _formatDate(detail.startedAt),
                duration: _formatDuration(detail.duration),
                totalExercises: detail.exercises.length,
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Exercícios ──
              ...detail.exercises.map(
                (exDetail) => _ExerciseDetailCard(detail: exDetail),
              ),

              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────── Header ───────────────

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({
    required this.dayName,
    required this.programName,
    required this.date,
    required this.duration,
    required this.totalExercises,
  });

  final String dayName;
  final String programName;
  final String date;
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
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primaryLight.withValues(alpha: 0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 40),
          const SizedBox(height: AppSpacing.sm),
          Text(
            dayName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            programName,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            date,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                icon: Icons.timer_outlined,
                label: AppStrings.duration,
                value: duration,
              ),
              _StatItem(
                icon: Icons.fitness_center,
                label: AppStrings.exercises,
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
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
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

// ─────────────── Card de Exercício ───────────────

class _ExerciseDetailCard extends StatelessWidget {
  const _ExerciseDetailCard({required this.detail});

  final SessionExerciseDetail detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exercise = detail.exercise;
    final sets = detail.sets;
    final nonSkippedSets = sets.where((s) => !s.wasSkipped).toList();

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Nome e contagem de séries ──
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
                  '${nonSkippedSets.length}/${exercise.sets} ${AppStrings.setsCompleted}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: nonSkippedSets.length >= exercise.sets
                        ? AppColors.success
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            // ── Rep range e RPE alvo ──
            const SizedBox(height: 4),
            Text(
              '${exercise.repMin}–${exercise.repMax} ${AppStrings.repRangeLabel}'
              '${exercise.rpeTarget != null ? '  ·  RPE ${exercise.rpeTarget}' : ''}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            if (sets.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              const Divider(height: 1),
              const SizedBox(height: AppSpacing.sm),

              // ── Lista de séries ──
              ...sets.map((s) => _SetRow(set: s, repMax: exercise.repMax)),
            ] else ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                AppStrings.noSetsRecorded,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],

            // ── Badge de progressão ──
            if (detail.progression != null) ...[
              const SizedBox(height: AppSpacing.sm),
              ProgressionBadgeWidget(
                result: detail.progression!,
                currentLoad: _maxLoad(nonSkippedSets),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _maxLoad(List<SetRecord> sets) {
    if (sets.isEmpty) return 0.0;
    return sets
        .where((s) => s.loadKg != null)
        .fold(0.0, (max, s) => s.loadKg! > max ? s.loadKg! : max);
  }
}

// ─────────────── Linha de Série ───────────────

class _SetRow extends StatelessWidget {
  const _SetRow({required this.set, required this.repMax});

  final SetRecord set;
  final int repMax;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (set.wasSkipped) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(
              'S${set.setNumber}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Pulada',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    final parts = <String>[];
    if (set.loadKg != null) {
      parts.add(
        '${set.loadKg!.toStringAsFixed(set.loadKg! % 1 == 0 ? 0 : 1)} kg',
      );
    }
    if (set.repsCompleted != null) {
      parts.add('${set.repsCompleted} reps');
    }
    if (set.rpeAchieved != null) {
      parts.add('RPE ${set.rpeAchieved}');
    }

    // Destaque verde se atingiu rep_max
    final hitMax = (set.repsCompleted ?? 0) >= repMax;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          // Número da série
          SizedBox(
            width: 32,
            child: Text(
              'S${set.setNumber}${set.isExtra ? " +" : ""}',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Dados da série
          Expanded(
            child: Text(
              parts.join(' · '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: hitMax ? AppColors.success : null,
                fontWeight: hitMax ? FontWeight.w600 : null,
              ),
            ),
          ),

          // Indicador de max alcançado
          if (hitMax)
            Icon(Icons.check_circle, color: AppColors.success, size: 16),

          // RPE badge
          if (set.rpeAchieved != null) ...[
            const SizedBox(width: AppSpacing.xs),
            Container(
              width: 28,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.colorForRpe(
                  set.rpeAchieved!,
                ).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '${set.rpeAchieved}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.colorForRpe(set.rpeAchieved!),
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
