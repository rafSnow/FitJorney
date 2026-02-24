import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/fj_button.dart';
import '../../domain/program_exercise.dart';

/// Parâmetros de configuração de um exercício no programa.
class ExerciseConfig {
  const ExerciseConfig({
    required this.sets,
    required this.repMin,
    required this.repMax,
    this.rpeTarget,
    required this.restSeconds,
  });

  final int sets;
  final int repMin;
  final int repMax;
  final int? rpeTarget;
  final int restSeconds;
}

/// Exibe bottom sheet para configurar séries, rep range, RPE e descanso.
///
/// Se [existing] for fornecido, os campos são pré-populados.
/// Retorna [ExerciseConfig] ou null se cancelado.
Future<ExerciseConfig?> showExerciseConfigBottomSheet(
  BuildContext context, {
  String? exerciseName,
  ProgramExercise? existing,
}) {
  return showModalBottomSheet<ExerciseConfig>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => _ExerciseConfigSheet(
      exerciseName: exerciseName,
      existing: existing,
    ),
  );
}

class _ExerciseConfigSheet extends StatefulWidget {
  const _ExerciseConfigSheet({this.exerciseName, this.existing});

  final String? exerciseName;
  final ProgramExercise? existing;

  @override
  State<_ExerciseConfigSheet> createState() => _ExerciseConfigSheetState();
}

class _ExerciseConfigSheetState extends State<_ExerciseConfigSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _setsCtrl;
  late final TextEditingController _repMinCtrl;
  late final TextEditingController _repMaxCtrl;
  late final TextEditingController _restCtrl;
  int? _rpeTarget;

  @override
  void initState() {
    super.initState();
    final ex = widget.existing;
    _setsCtrl = TextEditingController(text: '${ex?.sets ?? 3}');
    _repMinCtrl = TextEditingController(text: '${ex?.repMin ?? 8}');
    _repMaxCtrl = TextEditingController(text: '${ex?.repMax ?? 12}');
    _restCtrl = TextEditingController(text: '${ex?.restSeconds ?? 90}');
    _rpeTarget = ex?.rpeTarget;
  }

  @override
  void dispose() {
    _setsCtrl.dispose();
    _repMinCtrl.dispose();
    _repMaxCtrl.dispose();
    _restCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final config = ExerciseConfig(
      sets: int.parse(_setsCtrl.text),
      repMin: int.parse(_repMinCtrl.text),
      repMax: int.parse(_repMaxCtrl.text),
      rpeTarget: _rpeTarget,
      restSeconds: int.parse(_restCtrl.text),
    );
    Navigator.of(context).pop(config);
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Título
                Text(
                  widget.exerciseName != null
                      ? '${AppStrings.configureExercise}: ${widget.exerciseName}'
                      : AppStrings.configureExercise,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Séries
                _NumberField(
                  controller: _setsCtrl,
                  label: AppStrings.sets,
                  hint: '3',
                  min: 1,
                  max: 20,
                ),
                const SizedBox(height: AppSpacing.md),

                // Rep range — lado a lado
                Row(
                  children: [
                    Expanded(
                      child: _NumberField(
                        controller: _repMinCtrl,
                        label: 'Rep mín.',
                        hint: '8',
                        min: 1,
                        max: 100,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _NumberField(
                        controller: _repMaxCtrl,
                        label: 'Rep máx.',
                        hint: '12',
                        min: 1,
                        max: 100,
                        extraValidator: (v) {
                          final min = int.tryParse(_repMinCtrl.text);
                          final max = int.tryParse(v ?? '');
                          if (min != null && max != null && max < min) {
                            return 'Deve ser ≥ mín.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Descanso (segundos)
                _NumberField(
                  controller: _restCtrl,
                  label: '${AppStrings.restTime} (segundos)',
                  hint: '90',
                  min: 10,
                  max: 600,
                ),
                const SizedBox(height: AppSpacing.md),

                // RPE alvo (opcional)
                Text(
                  '${AppStrings.rpeTarget} (opcional)',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  children: [
                    FilterChip(
                      label: const Text('—'),
                      selected: _rpeTarget == null,
                      onSelected: (_) => setState(() => _rpeTarget = null),
                    ),
                    for (final rpe in [6, 7, 8, 9, 10])
                      FilterChip(
                        label: Text('$rpe'),
                        selected: _rpeTarget == rpe,
                        onSelected: (_) => setState(() => _rpeTarget = rpe),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                FJButton(
                  label: AppStrings.save,
                  icon: Icons.check,
                  onPressed: _save,
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Campo numérico inteiro com validação de range.
class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.min,
    required this.max,
    this.onChanged,
    this.extraValidator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final int min;
  final int max;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? extraValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(labelText: label, hintText: hint),
      onChanged: onChanged,
      validator: (v) {
        if (v == null || v.isEmpty) return AppStrings.fieldRequired;
        final n = int.tryParse(v);
        if (n == null) return 'Inválido';
        if (n < min) return 'Mínimo $min';
        if (n > max) return 'Máximo $max';
        return extraValidator?.call(v);
      },
    );
  }
}
