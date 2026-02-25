import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../domain/rest_timer_state.dart';

/// Widget de cronômetro de descanso — aparece como banner entre o conteúdo
/// e a barra de ações quando o descanso está em andamento.
///
/// Exibe: progresso circular + tempo restante + botões cancelar e reiniciar.
/// Anima entrada e saída com [AnimatedSize] + [AnimatedSwitcher].
class RestTimerWidget extends StatelessWidget {
  const RestTimerWidget({
    super.key,
    required this.state,
    required this.onCancel,
    required this.onRestart,
  });

  final RestTimerState state;
  final VoidCallback onCancel;
  final VoidCallback onRestart;

  String _fmt(int secs) {
    final m = (secs ~/ 60).toString().padLeft(2, '0');
    final s = (secs % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isVisible = state.isRunning || state.isDone;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      child: isVisible
          ? _TimerBanner(
              state: state,
              onCancel: onCancel,
              onRestart: onRestart,
              fmt: _fmt,
              theme: theme,
            )
          : const SizedBox.shrink(),
    );
  }
}

class _TimerBanner extends StatelessWidget {
  const _TimerBanner({
    required this.state,
    required this.onCancel,
    required this.onRestart,
    required this.fmt,
    required this.theme,
  });

  final RestTimerState state;
  final VoidCallback onCancel;
  final VoidCallback onRestart;
  final String Function(int) fmt;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final isDone = state.isDone;
    final accentColor = isDone ? AppColors.success : AppColors.primary;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isDone
            ? AppColors.success.withValues(alpha: 0.08)
            : theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(
          color: isDone
              ? AppColors.success.withValues(alpha: 0.5)
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          // ── Indicador circular ──
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedCircularTimer(
                  progress: state.progress,
                  color: accentColor,
                  backgroundColor: theme.colorScheme.outlineVariant,
                ),
                if (isDone)
                  Icon(Icons.check_circle, size: 18, color: AppColors.success),
              ],
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          // ── Label + tempo ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isDone ? AppStrings.restFinished : AppStrings.restTimer,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDone
                        ? AppColors.success
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) =>
                      FadeTransition(opacity: anim, child: child),
                  child: Text(
                    isDone
                        ? 'Pronto para a próxima!'
                        : fmt(state.remainingSeconds),
                    key: ValueKey(state.remainingSeconds),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDone
                          ? AppColors.success
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Botões de controle ──
          if (!isDone)
            IconButton(
              icon: const Icon(Icons.replay, size: 20),
              onPressed: onRestart,
              tooltip: 'Reiniciar',
              style: IconButton.styleFrom(
                minimumSize: const Size(36, 36),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),

          IconButton(
            icon: Icon(isDone ? Icons.close : Icons.close, size: 20),
            onPressed: onCancel,
            tooltip: 'Cancelar',
            style: IconButton.styleFrom(
              minimumSize: const Size(36, 36),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

/// Indicador circular animado — encapsula [CircularProgressIndicator]
/// para suavizar transições de progresso.
class AnimatedCircularTimer extends ImplicitlyAnimatedWidget {
  const AnimatedCircularTimer({
    super.key,
    required this.progress,
    required this.color,
    required this.backgroundColor,
  }) : super(duration: const Duration(milliseconds: 800));

  final double progress;
  final Color color;
  final Color backgroundColor;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedCircularTimer> createState() =>
      _AnimatedCircularTimerState();
}

class _AnimatedCircularTimerState
    extends AnimatedWidgetBaseState<AnimatedCircularTimer> {
  Tween<double>? _progressTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _progressTween =
        visitor(
              _progressTween,
              widget.progress,
              (v) => Tween<double>(begin: v as double),
            )
            as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: _progressTween?.evaluate(animation) ?? widget.progress,
      strokeWidth: 3.5,
      strokeCap: StrokeCap.round,
      backgroundColor: widget.backgroundColor,
      valueColor: AlwaysStoppedAnimation(widget.color),
    );
  }
}
