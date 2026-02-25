import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/progress_provider.dart';

/// Gráfico de linha: carga máxima por sessão ao longo do tempo.
class LoadChartWidget extends StatelessWidget {
  const LoadChartWidget({super.key, required this.dataPoints});

  final List<LoadDataPoint> dataPoints;

  @override
  Widget build(BuildContext context) {
    if (dataPoints.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final spots = <FlSpot>[];
    for (var i = 0; i < dataPoints.length; i++) {
      spots.add(FlSpot(i.toDouble(), dataPoints[i].maxLoad));
    }

    final minY = dataPoints
        .map((d) => d.maxLoad)
        .reduce((a, b) => a < b ? a : b);
    final maxY = dataPoints
        .map((d) => d.maxLoad)
        .reduce((a, b) => a > b ? a : b);
    final range = maxY - minY;
    final padding = range > 0 ? range * 0.15 : 5.0;

    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.only(
          right: AppSpacing.md,
          top: AppSpacing.sm,
        ),
        child: LineChart(
          LineChartData(
            minY: (minY - padding).clamp(0, double.maxFinite),
            maxY: maxY + padding,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: _calcInterval(minY, maxY),
              getDrawingHorizontalLine: (value) => FlLine(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: _calcBottomInterval(dataPoints.length),
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= dataPoints.length) {
                      return const SizedBox.shrink();
                    }
                    final date = dataPoints[index].date;
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${date.day}/${date.month}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 44,
                  interval: _calcInterval(minY, maxY),
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value == value.toInt().toDouble()
                          ? '${value.toInt()}'
                          : value.toStringAsFixed(1),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                preventCurveOverShooting: true,
                color: AppColors.primary,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) =>
                      FlDotCirclePainter(
                        radius: 4,
                        color: AppColors.primary,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (spot) => theme.colorScheme.inverseSurface,
                getTooltipItems: (spots) {
                  return spots.map((spot) {
                    final index = spot.x.toInt();
                    final dp = dataPoints[index];
                    final dateStr =
                        '${dp.date.day}/${dp.date.month}/${dp.date.year}';
                    return LineTooltipItem(
                      '${dp.maxLoad % 1 == 0 ? dp.maxLoad.toInt() : dp.maxLoad.toStringAsFixed(1)} kg\n',
                      TextStyle(
                        color: theme.colorScheme.onInverseSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '$dateStr · ${dp.reps} reps',
                          style: TextStyle(
                            color: theme.colorScheme.onInverseSurface
                                .withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calcInterval(double min, double max) {
    final range = max - min;
    if (range <= 0) return 5;
    if (range <= 10) return 2.5;
    if (range <= 25) return 5;
    if (range <= 50) return 10;
    if (range <= 100) return 20;
    return (range / 5).roundToDouble();
  }

  double _calcBottomInterval(int count) {
    if (count <= 7) return 1;
    if (count <= 15) return 2;
    if (count <= 30) return 5;
    return (count / 6).ceilToDouble();
  }
}
