import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/exercises/presentation/exercise_form_screen.dart';
import '../../features/exercises/presentation/exercises_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/programs/presentation/program_detail_screen.dart';
import '../../features/programs/presentation/program_form_screen.dart';
import '../../features/programs/presentation/programs_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/workout/domain/workout_provider.dart';
import '../../features/workout/presentation/workout_screen.dart';
import '../../features/workout/presentation/workout_summary_screen.dart';
import '../../shared/widgets/fj_button.dart';
import '../../shared/widgets/placeholder_screen.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_strings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Router principal do FitJourney usando go_router.
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/exercises',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ExercisesScreen()),
        ),
        GoRoute(
          path: '/programs',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProgramsScreen()),
        ),
        GoRoute(
          path: '/history',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HistoryScreen()),
        ),
        GoRoute(
          path: '/progress',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProgressScreen()),
        ),
      ],
    ),
    // Rotas fora do shell (sem bottom nav)
    GoRoute(
      path: '/exercises/new',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ExerciseFormScreen(),
    ),
    GoRoute(
      path: '/exercises/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        if (id == null) return const ExerciseFormScreen();
        return ExerciseFormScreen(exerciseId: id);
      },
    ),
    GoRoute(
      path: '/programs/new',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProgramFormScreen(),
    ),
    GoRoute(
      path: '/programs/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        if (id == null) return const ProgramsScreen();
        return ProgramDetailScreen(programId: id);
      },
    ),
    GoRoute(
      path: '/programs/:id/edit',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        if (id == null) return const ProgramFormScreen();
        return ProgramFormScreen(programId: id);
      },
    ),
    GoRoute(
      path: '/workout',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const WorkoutScreen(),
    ),
    GoRoute(
      path: '/workout/summary',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const WorkoutSummaryScreen(),
    ),
    GoRoute(
      path: '/history/:sessionId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => PlaceholderScreen(
        title: 'Sessão #${state.pathParameters['sessionId']}',
      ),
    ),
  ],
);

/// Home screen — ponto de entrada para iniciar ou retomar treino.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutAsync = ref.watch(activeWorkoutProvider);
    final nextDayAsync = ref.watch(nextWorkoutDayProvider);
    final theme = Theme.of(context);

    final hasActiveSession =
        workoutAsync.valueOrNull?.session.isInProgress == true;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Hero ──
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    AppColors.primaryLight.withValues(alpha: 0.07),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 56,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.appName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Treino baseado em ciência',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Retomar sessão em progresso ──
            if (hasActiveSession) ...[
              Card(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  side: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.play_circle_fill,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    'Treino em andamento',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Toque para retomar'),
                  onTap: () => context.push('/workout'),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],

            // ── Próximo treino ──
            nextDayAsync.when(
              loading: () => Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${AppStrings.nextWorkout}...',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              error: (_, __) => const SizedBox.shrink(),
              data: (day) {
                if (day == null) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 32,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            AppStrings.noActiveProgram,
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.noActiveProgramCta,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TextButton.icon(
                            icon: const Icon(Icons.list_alt),
                            label: const Text(AppStrings.programs),
                            onPressed: () => context.go('/programs'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Icon(Icons.event, color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.nextWorkout,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              Text(
                                day.name,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // ── Botão principal (thumb zone) ──
            nextDayAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
              data: (day) {
                if (hasActiveSession) {
                  return FJButton(
                    label: 'Retomar Treino',
                    icon: Icons.play_arrow,
                    onPressed: () => context.push('/workout'),
                  );
                }
                if (day == null) {
                  return FJButton(
                    label: AppStrings.programs,
                    icon: Icons.list_alt,
                    onPressed: () => context.go('/programs'),
                  );
                }
                return FJButton(
                  label: AppStrings.startWorkout,
                  icon: Icons.fitness_center,
                  onPressed: () async {
                    await ref
                        .read(activeWorkoutProvider.notifier)
                        .startWorkout(day.id);
                    if (context.mounted) context.push('/workout');
                  },
                );
              },
            ),

            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

/// Scaffold com BottomNavigationBar que envolve as rotas do ShellRoute.
class _ScaffoldWithNav extends StatelessWidget {
  const _ScaffoldWithNav({required this.child});

  final Widget child;

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/exercises')) return 1;
    if (location.startsWith('/programs')) return 2;
    if (location.startsWith('/history')) return 3;
    if (location.startsWith('/progress')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go('/');
            case 1:
              context.go('/exercises');
            case 2:
              context.go('/programs');
            case 3:
              context.go('/history');
            case 4:
              context.go('/progress');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: AppStrings.exercises,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: AppStrings.programs,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: AppStrings.history,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            activeIcon: Icon(Icons.show_chart),
            label: AppStrings.progress,
          ),
        ],
      ),
    );
  }
}
