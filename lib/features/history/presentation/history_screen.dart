import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/shimmer_loading.dart';
import '../domain/history_provider.dart';

/// Meses abreviados em pt-BR.
const _months = [
  'Jan',
  'Fev',
  'Mar',
  'Abr',
  'Mai',
  'Jun',
  'Jul',
  'Ago',
  'Set',
  'Out',
  'Nov',
  'Dez',
];

/// Tela de histórico — lista de sessões com data, duração, programa e filtro.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}min';
    return '${m}min ${s.toString().padLeft(2, '0')}s';
  }

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = _months[dt.month - 1];
    final year = dt.year;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$day $month $year · $hour:$minute';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(historySessionsProvider);
    final currentFilter = ref.watch(historyFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.history)),
      body: Column(
        children: [
          // ── Filtros de período ──
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                _FilterChip(
                  label: AppStrings.filterWeek,
                  selected: currentFilter == HistoryFilter.week,
                  onSelected: () =>
                      ref.read(historyFilterProvider.notifier).state =
                          HistoryFilter.week,
                ),
                const SizedBox(width: AppSpacing.sm),
                _FilterChip(
                  label: AppStrings.filterMonth,
                  selected: currentFilter == HistoryFilter.month,
                  onSelected: () =>
                      ref.read(historyFilterProvider.notifier).state =
                          HistoryFilter.month,
                ),
                const SizedBox(width: AppSpacing.sm),
                _FilterChip(
                  label: AppStrings.filterAll,
                  selected: currentFilter == HistoryFilter.all,
                  onSelected: () =>
                      ref.read(historyFilterProvider.notifier).state =
                          HistoryFilter.all,
                ),
              ],
            ),
          ),

          // ── Lista de sessões ──
          Expanded(
            child: sessionsAsync.when(
              loading: () => const SkeletonList(itemCount: 5),
              error: (_, __) =>
                  Center(child: Text(AppStrings.errorLoadingHistory)),
              data: (sessions) {
                if (sessions.isEmpty) {
                  return EmptyState(
                    icon: Icons.history,
                    title: AppStrings.noHistory,
                    message: AppStrings.noHistoryCta,
                    actionLabel: AppStrings.startWorkout,
                    onAction: () => context.go('/'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index];
                    return _SessionCard(
                      session: session,
                      formattedDuration: _formatDuration(session.duration),
                      formattedDate: _formatDate(session.startedAt),
                      onTap: () => context.push('/history/${session.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────── Filter Chip ───────────────

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        HapticFeedback.selectionClick();
        onSelected();
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.15),
      labelStyle: TextStyle(
        color: selected ? AppColors.primary : null,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: selected
            ? AppColors.primary.withValues(alpha: 0.4)
            : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
      ),
      showCheckmark: false,
    );
  }
}

// ─────────────── Session Card ───────────────

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.session,
    required this.formattedDuration,
    required this.formattedDate,
    required this.onTap,
  });

  final HistorySession session;
  final String formattedDuration;
  final String formattedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // ── Ícone de data ──
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${session.startedAt.day}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      _months[session.startedAt.month - 1],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 4),

              // ── Info da sessão ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.dayName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      session.programName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formattedDuration,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Indicador de progressão ──
              if (session.hadProgression)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: AppColors.success,
                    size: 18,
                  ),
                ),

              const SizedBox(width: AppSpacing.xs),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
