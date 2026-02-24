import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/loading_overlay.dart';
import '../domain/programs_provider.dart';
import 'widgets/program_card.dart';

/// Tela de programas — lista com programa ativo destacado.
class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final programsAsync = ref.watch(programsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.programs)),
      body: programsAsync.when(
        loading: () =>
            const LoadingOverlay(isLoading: true, child: SizedBox.expand()),
        error: (error, _) =>
            Center(child: Text('${AppStrings.genericError}\n$error')),
        data: (programs) {
          if (programs.isEmpty) {
            return EmptyState(
              icon: Icons.list_alt,
              title: AppStrings.noPrograms,
              message: AppStrings.noProgramsCta,
              actionLabel: AppStrings.newProgram,
              onAction: () => context.push('/programs/new'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
            itemCount: programs.length,
            itemBuilder: (context, index) {
              final program = programs[index];
              return ProgramCard(
                program: program,
                onTap: () => context.push('/programs/${program.id}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/programs/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
