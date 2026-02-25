import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Overlay animado de check para confirmação de série.
///
/// Exibe um ícone de check verde que escala de 0→1, segura brevemente,
/// e então desaparece com fade out. Auto-remove após a animação.
class AnimatedCheckOverlay extends StatefulWidget {
  const AnimatedCheckOverlay({super.key, this.onComplete});

  /// Callback chamado quando a animação termina.
  final VoidCallback? onComplete;

  @override
  State<AnimatedCheckOverlay> createState() => _AnimatedCheckOverlayState();
}

class _AnimatedCheckOverlayState extends State<AnimatedCheckOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Scale: 0 → 1.2 → 1.0 (bounce)
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.8), weight: 20),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Opacity: 1 → 1 → 0
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(scale: _scale.value, child: child),
        );
      },
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 40),
      ),
    );
  }
}

/// Efeito de celebração (confetti) para progressão de carga.
///
/// Mostra partículas coloridas que voam para fora do centro e somem.
class CelebrationEffect extends StatefulWidget {
  const CelebrationEffect({super.key, this.onComplete});

  final VoidCallback? onComplete;

  @override
  State<CelebrationEffect> createState() => _CelebrationEffectState();
}

class _CelebrationEffectState extends State<CelebrationEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    final random = Random();
    _particles = List.generate(12, (i) {
      final angle = (i / 12) * 2 * pi + random.nextDouble() * 0.5;
      return _Particle(
        angle: angle,
        distance: 60 + random.nextDouble() * 40,
        size: 6 + random.nextDouble() * 6,
        color: [
          AppColors.success,
          AppColors.primary,
          AppColors.primaryLight,
          const Color(0xFFFFD700), // gold
          AppColors.warning,
        ][random.nextInt(5)],
      );
    });

    _controller.forward().then((_) => widget.onComplete?.call());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final progress = _controller.value;
        final opacity = (1.0 - progress).clamp(0.0, 1.0);

        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ícone central
              Transform.scale(
                scale: progress < 0.3
                    ? Curves.elasticOut.transform(progress / 0.3)
                    : 1.0,
                child: Opacity(
                  opacity: progress < 0.8
                      ? 1.0
                      : (1.0 - (progress - 0.8) * 5).clamp(0.0, 1.0),
                  child: const Icon(
                    Icons.emoji_events,
                    color: AppColors.success,
                    size: 40,
                  ),
                ),
              ),
              // Partículas
              ...List.generate(_particles.length, (i) {
                final p = _particles[i];
                final dx = cos(p.angle) * p.distance * progress;
                final dy = sin(p.angle) * p.distance * progress;
                return Positioned(
                  left: 100 + dx - p.size / 2,
                  top: 100 + dy - p.size / 2,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      width: p.size,
                      height: p.size,
                      decoration: BoxDecoration(
                        color: p.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _Particle {
  const _Particle({
    required this.angle,
    required this.distance,
    required this.size,
    required this.color,
  });

  final double angle;
  final double distance;
  final double size;
  final Color color;
}
