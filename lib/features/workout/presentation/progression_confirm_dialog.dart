import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/fj_numeric_field.dart';

/// Exibe dialog de confirmação de nova carga com valor editável.
///
/// Retorna a carga confirmada pelo usuário, ou `null` se cancelado.
Future<double?> showProgressionConfirmDialog({
  required BuildContext context,
  required String exerciseName,
  required double currentLoad,
  required double suggestedLoad,
  required bool isIncrease,
}) {
  return showDialog<double>(
    context: context,
    builder: (ctx) => _ProgressionConfirmDialog(
      exerciseName: exerciseName,
      currentLoad: currentLoad,
      suggestedLoad: suggestedLoad,
      isIncrease: isIncrease,
    ),
  );
}

class _ProgressionConfirmDialog extends StatefulWidget {
  const _ProgressionConfirmDialog({
    required this.exerciseName,
    required this.currentLoad,
    required this.suggestedLoad,
    required this.isIncrease,
  });

  final String exerciseName;
  final double currentLoad;
  final double suggestedLoad;
  final bool isIncrease;

  @override
  State<_ProgressionConfirmDialog> createState() =>
      _ProgressionConfirmDialogState();
}

class _ProgressionConfirmDialogState extends State<_ProgressionConfirmDialog> {
  late double _newLoad;

  @override
  void initState() {
    super.initState();
    _newLoad = widget.suggestedLoad;
  }

  String _formatLoad(double load) {
    return load % 1 == 0
        ? load.toInt().toString()
        : load.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.isIncrease ? AppColors.success : AppColors.warning;
    final icon = widget.isIncrease ? Icons.trending_up : Icons.trending_down;
    final title = widget.isIncrease
        ? AppStrings.progressionDetected
        : AppStrings.regressionDetected;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nome do exercício
          Text(
            widget.exerciseName,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Carga atual → nova carga
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      AppStrings.currentLoad,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatLoad(widget.currentLoad)} kg',
                      style: theme.textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: color,
                    size: 24,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      AppStrings.suggestedLoad,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatLoad(widget.suggestedLoad)} kg',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Campo editável
          Text(
            'Ajuste a carga se necessário:',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          FJNumericField(
            label: 'Nova carga (kg)',
            value: _newLoad,
            onChanged: (v) => setState(() => _newLoad = v),
            step: 0.5,
            min: 0,
            max: 999,
            decimals: 1,
            suffix: 'kg',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton.icon(
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context, _newLoad);
          },
          icon: const Icon(Icons.check, size: 18),
          label: const Text(AppStrings.confirm),
          style: FilledButton.styleFrom(
            backgroundColor: color,
          ),
        ),
      ],
    );
  }
}
