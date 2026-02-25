import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/progression_constants.dart';
import '../../../shared/extensions/double_ext.dart';
import '../../../shared/widgets/fj_button.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import '../domain/exercises_provider.dart';
import 'widgets/youtube_player_widget.dart';

/// Tela de criação/edição de exercício.
class ExerciseFormScreen extends ConsumerStatefulWidget {
  const ExerciseFormScreen({super.key, this.exerciseId});

  /// Se null, é criação. Se preenchido, é edição.
  final int? exerciseId;

  bool get isEditing => exerciseId != null;

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _youtubeUrlController = TextEditingController();
  final _customIncrementController = TextEditingController();

  MuscleGroup _muscleGroup = MuscleGroup.chest;
  MuscleSize _muscleSize = MuscleSize.large;
  ExerciseType _exerciseType = ExerciseType.compound;
  MetricType _metricType = MetricType.loadKg;
  bool _useCustomIncrement = false;
  bool _isLoading = false;
  bool _isDeleting = false;
  bool _loaded = false;

  double get _suggestedIncrement => ProgressionConstants.getSuggestedIncrement(
    muscleSize: _muscleSize.value,
    exerciseType: _exerciseType.value,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _youtubeUrlController.dispose();
    _customIncrementController.dispose();
    super.dispose();
  }

  void _populateFromExercise(Exercise exercise) {
    if (_loaded) return;
    _loaded = true;
    _nameController.text = exercise.name;
    _muscleGroup = exercise.muscleGroup;
    _muscleSize = exercise.muscleSize;
    _exerciseType = exercise.exerciseType;
    _metricType = exercise.metricType;
    _youtubeUrlController.text = exercise.youtubeUrl ?? '';
    if (exercise.customIncrement != null) {
      _useCustomIncrement = true;
      _customIncrementController.text = exercise.customIncrement!
          .toCleanString();
    }
  }

  Future<void> _delete() async {
    final dao = ref.read(exercisesDaoProvider);

    // Verifica se está em programa ativo
    final inActive = await dao.isInActiveProgram(widget.exerciseId!);
    if (!mounted) return;

    if (inActive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.cannotDeleteActiveProgram),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Dialog de confirmação
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.deleteExerciseTitle),
        content: const Text(AppStrings.deleteExerciseMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);
    try {
      await dao.softDelete(widget.exerciseId!);
      HapticFeedback.lightImpact();
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.errorDeletingExercise),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final dao = ref.read(exercisesDaoProvider);
      final customIncrement = _useCustomIncrement
          ? double.tryParse(
              _customIncrementController.text.replaceAll(',', '.'),
            )
          : null;
      final youtubeUrl = _youtubeUrlController.text.trim().isNotEmpty
          ? _youtubeUrlController.text.trim()
          : null;

      if (widget.isEditing) {
        await dao.updateExercise(
          id: widget.exerciseId!,
          name: _nameController.text.trim(),
          muscleGroup: _muscleGroup,
          muscleSize: _muscleSize,
          exerciseType: _exerciseType,
          metricType: _metricType,
          youtubeUrl: youtubeUrl,
          customIncrement: customIncrement,
        );
      } else {
        await dao.insertExercise(
          name: _nameController.text.trim(),
          muscleGroup: _muscleGroup,
          muscleSize: _muscleSize,
          exerciseType: _exerciseType,
          metricType: _metricType,
          youtubeUrl: youtubeUrl,
          customIncrement: customIncrement,
        );
      }

      HapticFeedback.lightImpact();
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.errorSavingExercise),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se editando, carrega dados do exercício
    if (widget.isEditing) {
      final exerciseAsync = ref.watch(exerciseByIdProvider(widget.exerciseId!));
      return exerciseAsync.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text(AppStrings.editExercise)),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => Scaffold(
          appBar: AppBar(title: const Text(AppStrings.editExercise)),
          body: Center(child: Text(AppStrings.errorLoadingExercises)),
        ),
        data: (exercise) {
          if (exercise == null) {
            return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.editExercise)),
              body: const Center(child: Text('Exercício não encontrado')),
            );
          }
          _populateFromExercise(exercise);
          return _buildForm(context);
        },
      );
    }

    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? AppStrings.editExercise : AppStrings.newExercise,
        ),
        actions: [
          if (widget.isEditing)
            _isDeleting
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: AppStrings.deleteExerciseTitle,
                    color: theme.colorScheme.error,
                    onPressed: _delete,
                  ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Nome
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: AppStrings.exerciseName,
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.fieldRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // Grupo muscular
            DropdownButtonFormField<MuscleGroup>(
              initialValue: _muscleGroup,
              decoration: const InputDecoration(
                labelText: AppStrings.muscleGroup,
              ),
              items: MuscleGroup.values.map((g) {
                return DropdownMenuItem(value: g, child: Text(g.label));
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _muscleGroup = value;
                  _muscleSize = value.defaultSize;
                });
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // Tamanho do músculo
            Text(AppStrings.muscleSize, style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            _buildSegmentedControl<MuscleSize>(
              values: MuscleSize.values,
              selected: _muscleSize,
              labelOf: (v) => v.label,
              descriptionOf: (v) => v == MuscleSize.large
                  ? 'Peito, costas, pernas'
                  : 'Bíceps, tríceps, ombros',
              onChanged: (v) => setState(() => _muscleSize = v),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Tipo de exercício
            Text(AppStrings.exerciseType, style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            _buildSegmentedControl<ExerciseType>(
              values: ExerciseType.values,
              selected: _exerciseType,
              labelOf: (v) => v.label,
              descriptionOf: (v) => v == ExerciseType.compound
                  ? 'Move múltiplas articulações'
                  : 'Move uma articulação',
              onChanged: (v) => setState(() => _exerciseType = v),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Tipo de métrica
            Text(AppStrings.metricType, style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSpacing.sm),
            SegmentedButton<MetricType>(
              segments: MetricType.values.map((m) {
                return ButtonSegment(
                  value: m,
                  label: Text(m.label),
                  icon: Icon(
                    m == MetricType.loadKg
                        ? Icons.fitness_center
                        : Icons.timer_outlined,
                  ),
                );
              }).toList(),
              selected: {_metricType},
              onSelectionChanged: (selection) {
                setState(() => _metricType = selection.first);
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            // Incremento sugerido
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        AppStrings.suggestedIncrement,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    '+${_suggestedIncrement.toKgString()} por progressão',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Baseado em: ${_muscleSize.label.toLowerCase()} + ${_exerciseType.label.toLowerCase()}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Toggle incremento customizado
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.customIncrement,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Switch(
                        value: _useCustomIncrement,
                        onChanged: (v) => setState(() {
                          _useCustomIncrement = v;
                          if (!v) _customIncrementController.clear();
                        }),
                      ),
                    ],
                  ),
                  if (_useCustomIncrement) ...[
                    const SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _customIncrementController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Incremento (kg)',
                        hintText: '1.25',
                      ),
                      validator: (value) {
                        if (!_useCustomIncrement) return null;
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.fieldRequired;
                        }
                        final parsed = double.tryParse(
                          value.replaceAll(',', '.'),
                        );
                        if (parsed == null || parsed <= 0) {
                          return 'Valor inválido';
                        }
                        return null;
                      },
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // URL YouTube
            TextFormField(
              controller: _youtubeUrlController,
              decoration: const InputDecoration(
                labelText: AppStrings.youtubeUrl,
                hintText: 'https://youtube.com/watch?v=...',
                prefixIcon: Icon(Icons.play_circle_outline),
              ),
              keyboardType: TextInputType.url,
              onChanged: (_) => setState(() {}),
            ),

            // Preview da thumbnail
            if (_youtubeUrlController.text.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              YoutubeThumbnailPreview(
                youtubeUrl: _youtubeUrlController.text.trim(),
              ),
            ],

            const SizedBox(height: AppSpacing.xl),

            // Botão salvar
            FJButton(
              label: AppStrings.save,
              onPressed: _save,
              isLoading: _isLoading,
              icon: Icons.check,
            ),

            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  /// Segmented control customizado com descrição visual.
  Widget _buildSegmentedControl<T>({
    required List<T> values,
    required T selected,
    required String Function(T) labelOf,
    required String Function(T) descriptionOf,
    required ValueChanged<T> onChanged,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: values.map((value) {
        final isSelected = value == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: value != values.last ? AppSpacing.sm : 0,
            ),
            child: InkWell(
              onTap: () => onChanged(value),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: isSelected
                      ? Border.all(color: theme.colorScheme.primary, width: 2)
                      : Border.all(color: Colors.transparent, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      labelOf(value),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      descriptionOf(value),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
