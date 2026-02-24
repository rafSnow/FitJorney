import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/exercises/presentation/exercise_form_screen.dart';
import '../../features/exercises/presentation/exercises_screen.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/programs/presentation/program_detail_screen.dart';
import '../../features/programs/presentation/program_form_screen.dart';
import '../../features/programs/presentation/programs_screen.dart';
import '../../features/progress/presentation/progress_screen.dart';
import '../../features/workout/presentation/workout_screen.dart';
import '../../features/workout/presentation/workout_summary_screen.dart';
import '../../shared/widgets/placeholder_screen.dart';
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
      path: '/programs',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProgramsScreen(),
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

/// Home screen com bottom navigation.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Treino baseado em ciência',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
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
    if (location.startsWith('/history')) return 2;
    if (location.startsWith('/progress')) return 3;
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
              context.go('/history');
            case 3:
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
