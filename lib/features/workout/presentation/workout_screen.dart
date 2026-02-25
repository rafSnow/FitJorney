import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/animated_check_overlay.dart';
import '../../../shared/widgets/fj_button.dart';
import '../../../shared/widgets/fj_numeric_field.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../../programs/domain/program_exercise.dart';
import '../domain/rest_timer_provider.dart';
import '../domain/set_record.dart';
import '../domain/workout_provider.dart';
import '../domain/workout_state.dart';
import 'rest_timer_widget.dart';

/// Tela principal de sessão de treino ativa.
class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key});

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  late PageController _pageController;
  double _load = 0;
  int _reps = 0;
  int? _rpe;
  bool _isConfirming = false;
  bool _showCheck = false;

  // Timer de sessão
  Timer? _sessionTimer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Inicia o timer de sessão
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final workout = ref.read(activeWorkoutProvider).valueOrNull;
      if (workout != null && workout.session.isInProgress) {
        setState(() {
          _elapsed = workout.session.elapsed;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _sessionTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index, WorkoutState workout) {
    ref.read(activeWorkoutProvider.notifier).goToExercise(index);
    _resetInputForExercise(workout.exercises[index], workout);
  }

  void _resetInputForExercise(ProgramExercise ex, WorkoutState workout) {
    setState(() {
      _load = workout.lastLoadFor(ex.id);
      _reps = ex.repMax;
      _rpe = ex.rpeTarget;
    });
  }

  Future<void> _confirmSet(WorkoutState workout) async {
    if (_isConfirming) return;
    final ex = workout.currentExercise;
    if (ex == null) return;

    setState(() => _isConfirming = true);
    HapticFeedback.lightImpact();

    final doneSets = workout
        .setsForExercise(ex.id)
        .where((s) => !s.wasSkipped && !s.isExtra);
    final isExtra = doneSets.length >= ex.sets;
    final setNumber = workout.nextSetNumberFor(ex.id);

    await ref
        .read(activeWorkoutProvider.notifier)
        .recordSet(
          programExerciseId: ex.id,
          setNumber: setNumber,
          loadKg: _load > 0 ? _load : null,
          repsCompleted: _reps > 0 ? _reps : null,
          rpeAchieved: _rpe,
          isExtra: isExtra,
        );

    // 2.2.2 — Auto-inicia cronômetro de descanso após confirmar série
    final restSeconds = ex.restSeconds > 0 ? ex.restSeconds : 90;
    await ref
        .read(restTimerProvider.notifier)
        .start(restSeconds, exerciseName: ex.exerciseName ?? '');

    // 4.2 — Micro-animação: check animado ao confirmar série
    setState(() {
      _isConfirming = false;
      _showCheck = true;
    });
  }

  Future<void> _skipSet(WorkoutState workout) async {
    final ex = workout.currentExercise;
    if (ex == null) return;
    final setNumber = workout.nextSetNumberFor(ex.id);
    await ref
        .read(activeWorkoutProvider.notifier)
        .skipSet(programExerciseId: ex.id, setNumber: setNumber);
  }

  Future<void> _confirmFinish(WorkoutState workout) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.finishWorkout),
        content: const Text('Deseja finalizar o treino agora?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              AppStrings.finishWorkout,
              style: TextStyle(
                color: Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    HapticFeedback.heavyImpact();
    // Cancela o descanso ao finalizar treino
    await ref.read(restTimerProvider.notifier).cancel();
    await ref.read(activeWorkoutProvider.notifier).finishWorkout();
    if (!mounted) return;
    context.push('/workout/summary');
  }

  Future<void> _confirmAbandon() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Abandonar treino?'),
        content: const Text(
          'O treino será cancelado. As séries já confirmadas serão descartadas.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Abandonar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    // Cancela o descanso ao abandonar treino
    await ref.read(restTimerProvider.notifier).cancel();
    await ref.read(activeWorkoutProvider.notifier).abandonWorkout();
    if (!mounted) return;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final workoutAsync = ref.watch(activeWorkoutProvider);

    ref.listen<AsyncValue<WorkoutState?>>(activeWorkoutProvider, (prev, next) {
      final idx = next.valueOrNull?.currentExerciseIndex;
      if (idx != null &&
          (_pageController.hasClients) &&
          idx != _pageController.page?.round()) {
        _goToPage(idx);
      }
    });

    return workoutAsync.when(
      loading: () => const Scaffold(
        body: LoadingOverlay(isLoading: true, child: SizedBox.expand()),
      ),
      error: (_, __) =>
          Scaffold(body: Center(child: Text(AppStrings.errorLoadingWorkout))),
      data: (workout) {
        if (workout == null) return _buildNoWorkout(context);
        if (workout.session.isCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) context.push('/workout/summary');
          });
          return const Scaffold(
            body: LoadingOverlay(isLoading: true, child: SizedBox.expand()),
          );
        }
        // Inicializa o input para o exercício corrente na primeira renderização
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _load == 0 && _reps == 0) {
            final ex = workout.currentExercise;
            if (ex != null) {
              setState(() {
                _load = workout.lastLoadFor(ex.id);
                _reps = ex.repMax;
                _rpe = ex.rpeTarget;
              });
            }
          }
        });
        return _buildWorkout(context, workout);
      },
    );
  }

  Widget _buildNoWorkout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.startWorkout)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noActiveProgram,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.noActiveProgramCta,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: FJButton(
                label: AppStrings.programs,
                icon: Icons.list_alt,
                onPressed: () => context.push('/programs'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkout(BuildContext context, WorkoutState workout) {
    final currentIdx = workout.currentExerciseIndex;
    final totalExercises = workout.exercises.length;
    final restTimer = ref.watch(restTimerProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout.dayName,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Ex ${currentIdx + 1}/$totalExercises · ${_formatDuration(_elapsed)}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            tooltip: AppStrings.finishWorkout,
            onPressed: () => _confirmFinish(workout),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Abandonar',
            onPressed: _confirmAbandon,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: workout.exercises.length,
                  onPageChanged: (idx) => _onPageChanged(idx, workout),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final ex = workout.exercises[index];
                    final sets = workout.setsForExercise(ex.id);
                    final isCurrent = index == currentIdx;
                    return _ExercisePage(
                      exercise: ex,
                      recordedSets: sets,
                      isCurrentPage: isCurrent,
                      load: isCurrent ? _load : workout.lastLoadFor(ex.id),
                      reps: isCurrent ? _reps : ex.repMax,
                      rpe: isCurrent ? _rpe : ex.rpeTarget,
                      onLoadChanged: (v) => setState(() => _load = v),
                      onRepsChanged: (v) => setState(() => _reps = v.toInt()),
                      onRpeChanged: (v) => setState(() => _rpe = v),
                    );
                  },
                ),
              ),
              _ExerciseDots(
                count: totalExercises,
                currentIndex: currentIdx,
                completedFlags: List.generate(
                  totalExercises,
                  (i) => workout.isExerciseComplete(i),
                ),
              ),
              // 2.2.3 — Cronômetro de descanso (aparece entre dots e action bar)
              RestTimerWidget(
                state: restTimer,
                onCancel: () => ref.read(restTimerProvider.notifier).cancel(),
                onRestart: () => ref.read(restTimerProvider.notifier).restart(),
              ),
              _BottomActionBar(
                workout: workout,
                currentIdx: currentIdx,
                isConfirming: _isConfirming,
                onConfirm: () => _confirmSet(workout),
                onSkip: () => _skipSet(workout),
                onPrev: currentIdx > 0 ? () => _goToPage(currentIdx - 1) : null,
                onNext: currentIdx < totalExercises - 1
                    ? () => _goToPage(currentIdx + 1)
                    : null,
                onFinish: () => _confirmFinish(workout),
              ),
            ],
          ),

          // 4.2 — Overlay de check animado
          if (_showCheck)
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: AnimatedCheckOverlay(
                    onComplete: () {
                      if (mounted) setState(() => _showCheck = false);
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────── Página de exercício ───────────────

class _ExercisePage extends StatelessWidget {
  const _ExercisePage({
    required this.exercise,
    required this.recordedSets,
    required this.isCurrentPage,
    required this.load,
    required this.reps,
    this.rpe,
    required this.onLoadChanged,
    required this.onRepsChanged,
    required this.onRpeChanged,
  });

  final ProgramExercise exercise;
  final List<SetRecord> recordedSets;
  final bool isCurrentPage;
  final double load;
  final int reps;
  final int? rpe;
  final ValueChanged<double> onLoadChanged;
  final ValueChanged<double> onRepsChanged;
  final ValueChanged<int?> onRpeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final doneSets = recordedSets
        .where((s) => !s.wasSkipped && !s.isExtra)
        .length;
    final planned = exercise.sets;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.exerciseName ?? 'Exercício',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              _InfoChip(label: '$planned séries', icon: Icons.repeat),
              _InfoChip(
                label: '${exercise.repMin}–${exercise.repMax} reps',
                icon: Icons.fitness_center,
              ),
              if (exercise.rpeTarget != null)
                _InfoChip(
                  label: 'RPE ${exercise.rpeTarget}',
                  icon: Icons.speed,
                  color: AppColors.colorForRpe(exercise.rpeTarget!),
                ),
              _InfoChip(
                label: '${exercise.restSeconds}s',
                icon: Icons.timer_outlined,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SetList(exercise: exercise, recordedSets: recordedSets),
          const SizedBox(height: AppSpacing.md),
          if (isCurrentPage) ...[
            Text(
              'Série ${doneSets + 1}${doneSets >= planned ? " (extra)" : ""}',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            FJNumericField(
              label: AppStrings.load,
              value: load,
              step: 2.5,
              min: 0,
              max: 999,
              decimals: 2,
              suffix: 'kg',
              onChanged: onLoadChanged,
            ),
            const SizedBox(height: AppSpacing.sm),
            FJNumericField(
              label: AppStrings.repsCompleted,
              value: reps.toDouble(),
              step: 1,
              min: 0,
              max: 99,
              decimals: 0,
              onChanged: onRepsChanged,
            ),
            const SizedBox(height: AppSpacing.sm),
            _RpeSelector(selected: rpe, onChanged: onRpeChanged),
          ],
          const SizedBox(height: 160),
        ],
      ),
    );
  }
}

// ─────────────── Lista de séries ───────────────

class _SetList extends StatelessWidget {
  const _SetList({required this.exercise, required this.recordedSets});

  final ProgramExercise exercise;
  final List<SetRecord> recordedSets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final planned = exercise.sets;
    final maxSet = recordedSets.fold(
      0,
      (v, s) => s.setNumber > v ? s.setNumber : v,
    );
    final totalRows = maxSet > planned ? maxSet : planned;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 32,
              child: Text(
                '#',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Carga',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            SizedBox(
              width: 48,
              child: Text(
                'Reps',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 48,
              child: Text(
                'RPE',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const Divider(height: 8),
        ...List.generate(totalRows, (i) {
          final setNum = i + 1;
          final record = recordedSets
              .where((s) => s.setNumber == setNum)
              .firstOrNull;
          return _SetRow(
            setNumber: setNum,
            record: record,
            isExtra: setNum > planned,
          );
        }),
      ],
    );
  }
}

class _SetRow extends StatelessWidget {
  const _SetRow({required this.setNumber, this.record, required this.isExtra});

  final int setNumber;
  final SetRecord? record;
  final bool isExtra;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDone = record != null && !record!.wasSkipped;
    final isSkipped = record?.wasSkipped ?? false;

    Color rowColor = Colors.transparent;
    if (isDone) rowColor = AppColors.success.withValues(alpha: 0.08);
    if (isSkipped) {
      rowColor = theme.colorScheme.onSurface.withValues(alpha: 0.04);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: isDone
                ? const Icon(Icons.check, size: 14, color: AppColors.success)
                : isSkipped
                ? Icon(
                    Icons.skip_next,
                    size: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  )
                : Text(
                    '$setNumber',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
          Expanded(
            child: Text(
              isDone && record!.loadKg != null
                  ? '${record!.loadKg!.toStringAsFixed(record!.loadKg! % 1 == 0 ? 0 : 1)} kg'
                  : isSkipped
                  ? 'Pulado'
                  : '—',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDone
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isDone ? FontWeight.w600 : null,
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: Text(
              isDone && record!.repsCompleted != null
                  ? '${record!.repsCompleted}'
                  : '—',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDone
                    ? theme.colorScheme.onSurface
                    : theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 48,
            child: record?.rpeAchieved != null
                ? Container(
                    width: 32,
                    height: 20,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.colorForRpe(
                        record!.rpeAchieved!,
                      ).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${record!.rpeAchieved}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.colorForRpe(record!.rpeAchieved!),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Text(
                    '—',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────── RPE Selector ───────────────

class _RpeSelector extends StatelessWidget {
  const _RpeSelector({required this.selected, required this.onChanged});

  final int? selected;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.rpeAchieved,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _RpeChip(
                label: '—',
                isSelected: selected == null,
                color: theme.colorScheme.onSurfaceVariant,
                onTap: () => onChanged(null),
              ),
              ...List.generate(5, (i) {
                final val = 6 + i;
                return _RpeChip(
                  label: '$val',
                  isSelected: selected == val,
                  color: AppColors.colorForRpe(val),
                  onTap: () => onChanged(val),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _RpeChip extends StatelessWidget {
  const _RpeChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: Semantics(
        label: label == '—' ? 'RPE nenhum' : 'RPE $label',
        selected: isSelected,
        button: true,
        child: GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            onTap();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isSelected ? color : color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? color : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────── Bottom action bar ───────────────

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.workout,
    required this.currentIdx,
    required this.isConfirming,
    required this.onConfirm,
    required this.onSkip,
    this.onPrev,
    this.onNext,
    required this.onFinish,
  });

  final WorkoutState workout;
  final int currentIdx;
  final bool isConfirming;
  final VoidCallback onConfirm;
  final VoidCallback onSkip;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allDone = workout.allExercisesComplete;
    final currentEx = workout.currentExercise;
    final doneSets = currentEx != null
        ? workout.setsForExercise(currentEx.id).where((s) => !s.isExtra).length
        : 0;
    final isCurrentDone = currentEx != null && doneSets >= currentEx.sets;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FJButton(
              label: isCurrentDone
                  ? AppStrings.addExtraSet
                  : AppStrings.confirmSet,
              icon: isCurrentDone ? Icons.add : Icons.check,
              isLoading: isConfirming,
              onPressed: isConfirming ? null : onConfirm,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                _NavIconButton(
                  icon: Icons.chevron_left,
                  onPressed: onPrev,
                  tooltip: 'Exercício anterior',
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.skip_next, size: 18),
                    label: Text(
                      AppStrings.skipSet,
                      style: const TextStyle(fontSize: 13),
                    ),
                    onPressed: isCurrentDone ? null : onSkip,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 44),
                    ),
                  ),
                ),
                if (allDone) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.flag, size: 18),
                      label: const Text(
                        'Finalizar',
                        style: TextStyle(fontSize: 13),
                      ),
                      onPressed: onFinish,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        backgroundColor: AppColors.success,
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: AppSpacing.xs),
                _NavIconButton(
                  icon: Icons.chevron_right,
                  onPressed: onNext,
                  tooltip: 'Próximo exercício',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIconButton extends StatelessWidget {
  const _NavIconButton({
    required this.icon,
    this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: tooltip,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────── Indicadores de página ───────────────

class _ExerciseDots extends StatelessWidget {
  const _ExerciseDots({
    required this.count,
    required this.currentIndex,
    required this.completedFlags,
  });

  final int count;
  final int currentIndex;
  final List<bool> completedFlags;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final isActive = i == currentIndex;
          final isDone = completedFlags[i];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isDone
                  ? AppColors.success
                  : isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────── Info Chip ───────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.icon, this.color});

  final String label;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: effectiveColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
