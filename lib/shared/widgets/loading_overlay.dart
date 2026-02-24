import 'package:flutter/material.dart';

/// Overlay de loading que não bloqueia scroll.
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.6),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
