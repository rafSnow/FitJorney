import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_spacing.dart';

/// Campo numérico com botões +/- laterais. Teclado numérico obrigatório.
class FJNumericField extends StatefulWidget {
  const FJNumericField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.step = 1.0,
    this.min = 0.0,
    this.max = 9999.0,
    this.decimals = 1,
    this.suffix,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double step;
  final double min;
  final double max;
  final int decimals;
  final String? suffix;

  @override
  State<FJNumericField> createState() => _FJNumericFieldState();
}

class _FJNumericFieldState extends State<FJNumericField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatValue(widget.value));
  }

  @override
  void didUpdateWidget(FJNumericField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      final text = _formatValue(widget.value);
      if (_controller.text != text) {
        _controller.text = text;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatValue(double v) {
    if (widget.decimals == 0) return v.toInt().toString();
    // Remove trailing zeros
    final formatted = v.toStringAsFixed(widget.decimals);
    if (formatted.contains('.')) {
      final trimmed = formatted
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll(RegExp(r'\.$'), '');
      return trimmed.isEmpty ? '0' : trimmed;
    }
    return formatted;
  }

  void _increment() {
    final newValue = (widget.value + widget.step).clamp(widget.min, widget.max);
    HapticFeedback.selectionClick();
    widget.onChanged(newValue);
  }

  void _decrement() {
    final newValue = (widget.value - widget.step).clamp(widget.min, widget.max);
    HapticFeedback.selectionClick();
    widget.onChanged(newValue);
  }

  void _onTextChanged(String text) {
    final parsed = double.tryParse(text.replaceAll(',', '.'));
    if (parsed != null) {
      final clamped = parsed.clamp(widget.min, widget.max);
      widget.onChanged(clamped);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            _RoundButton(
              icon: Icons.remove,
              onPressed: widget.value > widget.min ? _decrement : null,
              semanticLabel: 'Diminuir ${widget.label}',
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  suffixText: widget.suffix,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.sm,
                  ),
                ),
                onChanged: _onTextChanged,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _RoundButton(
              icon: Icons.add,
              onPressed: widget.value < widget.max ? _increment : null,
              semanticLabel: 'Aumentar ${widget.label}',
            ),
          ],
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.onPressed,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: SizedBox(
        width: 48,
        height: 48,
        child: IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
          ),
        ),
      ),
    );
  }
}
