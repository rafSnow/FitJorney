import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../domain/progression_engine.dart';

/// Badge de destaque visual quando progressão (aumento ou redução) é detectada.
///
/// Mostra ícone, título, carga sugerida e um botão para confirmar/editar.
/// Usado na tela de resumo do treino (WorkoutSummaryScreen).
class ProgressionBadgeWidget extends StatelessWidget {
  const ProgressionBadgeWidget({
    super.key,
    required this.result,
    required this.currentLoad,
    this.onTap,
  });

  final ProgressionResult result;
  final double currentLoad;
  final VoidCallback? onTap;

  String _formatLoad(double load) {
    return load % 1 == 0
        ? load.toInt().toString()
        : load.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final isIncrease = result.shouldIncreaseLoad;
    final color = isIncrease ? AppColors.success : AppColors.warning;
    final icon = isIncrease ? Icons.trending_up : Icons.trending_down;
    final title = isIncrease
        ? AppStrings.progressionDetected
        : AppStrings.regressionDetected;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppSpacing.sm + 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Row(
          children: [
            // Ícone animado
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (result.suggestedNewLoad != null)
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: color, fontSize: 12),
                        children: [
                          TextSpan(
                            text: '${_formatLoad(currentLoad)} kg',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const TextSpan(text: '  →  '),
                          TextSpan(
                            text: '${_formatLoad(result.suggestedNewLoad!)} kg',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Botão de ação
            if (onTap != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline, color: color, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.confirm,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
