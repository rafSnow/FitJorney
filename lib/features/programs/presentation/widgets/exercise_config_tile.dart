import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../domain/program_exercise.dart';

/// Tile de configuração de exercício no programa.
class ExerciseConfigTile extends StatelessWidget {
  const ExerciseConfigTile({
    super.key,
    required this.programExercise,
    this.onTap,
    this.onDelete,
    this.reorderHandle,
  });

  final ProgramExercise programExercise;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Widget? reorderHandle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              if (reorderHandle != null) ...[
                reorderHandle!,
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      programExercise.exerciseName ??
                          'Exercício #${programExercise.exerciseId}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        _InfoChip(
                          icon: Icons.repeat,
                          label:
                              '${programExercise.sets}x${programExercise.repMin}-${programExercise.repMax}',
                        ),
                        if (programExercise.rpeTarget != null)
                          _InfoChip(
                            icon: Icons.speed,
                            label: 'RPE ${programExercise.rpeTarget}',
                          ),
                        _InfoChip(
                          icon: Icons.timer_outlined,
                          label: '${programExercise.restSeconds}s',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onDelete,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 2),
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
