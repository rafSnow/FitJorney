import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/progression_constants.dart';
import '../../../../shared/extensions/double_ext.dart';
import '../../../../shared/widgets/fj_card.dart';
import '../../domain/exercise.dart';

/// Card de exercício para a listagem.
class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise, required this.onTap});

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final increment =
        exercise.customIncrement ??
        ProgressionConstants.getSuggestedIncrement(
          muscleSize: exercise.muscleSize.value,
          exerciseType: exercise.exerciseType.value,
        );

    return FJCard(
      onTap: onTap,
      child: Row(
        children: [
          // Ícone do grupo muscular
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Icon(
              _iconForMuscleGroup(exercise.muscleGroup.value),
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    _Chip(
                      label: exercise.muscleGroup.label,
                      color: theme.colorScheme.secondaryContainer,
                      textColor: theme.colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    _Chip(
                      label: exercise.exerciseType.label,
                      color: theme.colorScheme.tertiaryContainer,
                      textColor: theme.colorScheme.onTertiaryContainer,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Incremento
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${increment.toKgString()}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (exercise.youtubeUrl != null &&
                  exercise.youtubeUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconForMuscleGroup(String group) {
    return switch (group) {
      'chest' => Icons.fitness_center,
      'back' => Icons.fitness_center,
      'shoulders' => Icons.fitness_center,
      'biceps' => Icons.fitness_center,
      'triceps' => Icons.fitness_center,
      'forearm' => Icons.fitness_center,
      'quadriceps' => Icons.directions_run,
      'hamstrings' => Icons.directions_run,
      'glutes' => Icons.directions_run,
      'calves' => Icons.directions_run,
      'core' => Icons.self_improvement,
      'fullBody' => Icons.accessibility_new,
      _ => Icons.fitness_center,
    };
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: textColor),
      ),
    );
  }
}
