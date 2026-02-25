import 'package:flutter/material.dart';

/// Widget de shimmer/skeleton para estados de carregamento.
///
/// Exibe retângulos ou círculos com animação de brilho pulsante
/// que simula o conteúdo sendo carregado.
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key, required this.child});

  /// O widget skeleton (usa [ShimmerBox] para blocos individuais).
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShimmerProvider(animation: _animation, child: widget.child);
      },
    );
  }
}

/// InheritedWidget para compartilhar a animação do shimmer.
class ShimmerProvider extends InheritedWidget {
  const ShimmerProvider({
    super.key,
    required this.animation,
    required super.child,
  });

  final Animation<double> animation;

  static ShimmerProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShimmerProvider>();
  }

  @override
  bool updateShouldNotify(ShimmerProvider oldWidget) => true;
}

/// Bloco retangular com efeito shimmer para usar como placeholder.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = 8,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final provider = ShimmerProvider.of(context);
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainerHighest;
    final highlightColor = theme.colorScheme.surfaceContainerLow;

    final opacity = provider?.animation.value ?? 0.5;
    final color = Color.lerp(baseColor, highlightColor, opacity) ?? baseColor;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Skeleton de card para listagem (exercícios, programas, histórico).
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          const ShimmerBox(width: 48, height: 48, borderRadius: 12),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: MediaQuery.sizeOf(context).width * 0.4),
                const SizedBox(height: 8),
                const ShimmerBox(width: 120, height: 12),
              ],
            ),
          ),
          const ShimmerBox(width: 40, height: 16),
        ],
      ),
    );
  }
}

/// Skeleton de listagem — mostra N cards skeleton.
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) => const SkeletonCard(),
      ),
    );
  }
}
