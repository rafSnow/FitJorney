import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/fj_button.dart';
import '../domain/programs_provider.dart';

/// Tela de criação/edição de programa.
///
/// Passo 1: nome + número de dias.
/// Passo 2: nomear cada dia.
class ProgramFormScreen extends ConsumerStatefulWidget {
  const ProgramFormScreen({super.key, this.programId});

  final int? programId;

  bool get isEditing => programId != null;

  @override
  ConsumerState<ProgramFormScreen> createState() => _ProgramFormScreenState();
}

class _ProgramFormScreenState extends ConsumerState<ProgramFormScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _dayCount = 3;
  int _currentStep = 0;
  List<TextEditingController> _dayNameControllers = [];
  bool _isLoading = false;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _generateDayControllers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final c in _dayNameControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _generateDayControllers() {
    // Dispor antigos
    for (final c in _dayNameControllers) {
      c.dispose();
    }
    _dayNameControllers = List.generate(
      _dayCount,
      (i) =>
          TextEditingController(text: 'Treino ${String.fromCharCode(65 + i)}'),
    );
  }

  void _populateFromExisting() {
    if (_loaded || !widget.isEditing) return;
    _loaded = true;
    final programAsync = ref.read(programByIdProvider(widget.programId!));
    final daysAsync = ref.read(programDaysProvider(widget.programId!));
    programAsync.whenData((program) {
      if (program != null) {
        _nameController.text = program.name;
      }
    });
    daysAsync.whenData((days) {
      _dayCount = days.length;
      for (final c in _dayNameControllers) {
        c.dispose();
      }
      _dayNameControllers = days
          .map((d) => TextEditingController(text: d.name))
          .toList();
    });
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    try {
      final dao = ref.read(programsDaoProvider);
      final dayNames = _dayNameControllers.map((c) => c.text.trim()).toList();

      if (widget.isEditing) {
        // Atualiza nome do programa
        await dao.updateProgramName(
          id: widget.programId!,
          name: _nameController.text.trim(),
        );
        // Recria dias: deleta antigos e insere novos
        final existingDays = await dao.getDays(widget.programId!);
        for (final day in existingDays) {
          await dao.deleteDay(day.id);
        }
        await dao.insertDays(programId: widget.programId!, dayNames: dayNames);
      } else {
        final programId = await dao.insertProgram(
          name: _nameController.text.trim(),
        );
        await dao.insertDays(programId: programId, dayNames: dayNames);
      }

      HapticFeedback.lightImpact();
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.errorSavingProgram),
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
    if (widget.isEditing) {
      // Pre-carrega dados
      ref.watch(programByIdProvider(widget.programId!));
      ref.watch(programDaysProvider(widget.programId!));
      _populateFromExisting();
    }

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? AppStrings.editProgram : AppStrings.newProgram,
        ),
      ),
      body: Form(
        key: _formKey,
        child: _currentStep == 0 ? _buildStep1(theme) : _buildStep2(theme),
      ),
    );
  }

  /// Passo 1: Nome do programa + número de dias.
  Widget _buildStep1(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          'Passo 1 de 2',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Defina o nome e quantos dias terá o programa',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Nome
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: AppStrings.programName,
            hintText: 'Ex: Push Pull Legs',
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

        // Número de dias
        Text('Número de dias', style: theme.textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filled(
              onPressed: _dayCount > 1
                  ? () {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _dayCount--;
                        _generateDayControllers();
                      });
                    }
                  : null,
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: AppSpacing.lg),
            Text(
              '$_dayCount',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            IconButton.filled(
              onPressed: _dayCount < 7
                  ? () {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _dayCount++;
                        _generateDayControllers();
                      });
                    }
                  : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: Text(
            _dayCount == 1 ? '1 dia de treino' : '$_dayCount dias de treino',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),

        FJButton(
          label: 'Próximo',
          icon: Icons.arrow_forward,
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            setState(() => _currentStep = 1);
          },
        ),
      ],
    );
  }

  /// Passo 2: Nomear cada dia.
  Widget _buildStep2(ThemeData theme) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          'Passo 2 de 2',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Nomeie cada dia do programa',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        for (var i = 0; i < _dayNameControllers.length; i++) ...[
          TextFormField(
            controller: _dayNameControllers[i],
            decoration: InputDecoration(
              labelText: 'Dia ${i + 1}',
              hintText: 'Ex: Push, Pull, Legs...',
              prefixIcon: CircleAvatar(
                radius: 14,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  '${i + 1}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppStrings.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        const SizedBox(height: AppSpacing.lg),

        Row(
          children: [
            Expanded(
              child: FJButton(
                label: 'Voltar',
                icon: Icons.arrow_back,
                isOutlined: true,
                onPressed: () => setState(() => _currentStep = 0),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: FJButton(
                label: AppStrings.save,
                icon: Icons.check,
                isLoading: _isLoading,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  _save();
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
