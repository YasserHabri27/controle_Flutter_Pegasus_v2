import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../../../theme/app_theme.dart';

/// A widget displaying interactive charts with tab switching
/// Supports line charts, bar charts, and pie charts
class ChartSectionWidget extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> chartData;
  final ChartType chartType;

  const ChartSectionWidget({
    super.key,
    required this.title,
    required this.chartData,
    this.chartType = ChartType.line,
  });

  @override
  State<ChartSectionWidget> createState() => _ChartSectionWidgetState();
}

class _ChartSectionWidgetState extends State<ChartSectionWidget> {
  int _selectedPeriod = 0; // 0: Weekly, 1: Monthly

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPeriodButton('Semaine', 0, theme),
                    _buildPeriodButton('Mois', 1, theme),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 30.h,
            child: widget.chartType == ChartType.line
                ? _buildLineChart(theme)
                : widget.chartType == ChartType.bar
                ? _buildBarChart(theme)
                : _buildPieChart(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String label, int index, ThemeData theme) {
    final isSelected = _selectedPeriod == index;
    return InkWell(
      onTap: () => setState(() => _selectedPeriod = index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart(ThemeData theme) {
    return Semantics(
      label: "Graphique linéaire des tendances de productivité",
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.colorScheme.outline.withValues(alpha: 0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final labels = _selectedPeriod == 0
                      ? ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim']
                      : ['S1', 'S2', 'S3', 'S4'];
                  if (value.toInt() >= 0 && value.toInt() < labels.length) {
                    return Text(
                      labels[value.toInt()],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (_selectedPeriod == 0 ? 6 : 3).toDouble(),
          minY: 0,
          maxY: 25,
          lineBarsData: [
            LineChartBarData(
              spots: _getLineChartSpots(),
              isCurved: true,
              color: theme.colorScheme.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: theme.colorScheme.primary,
                    strokeWidth: 2,
                    strokeColor: theme.colorScheme.surface,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(ThemeData theme) {
    return Semantics(
      label: "Graphique à barres de la progression des workflows",
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.toInt()}%',
                  theme.textTheme.labelSmall!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final labels = ['W1', 'W2', 'W3', 'W4'];
                  if (value.toInt() >= 0 && value.toInt() < labels.length) {
                    return Text(
                      labels[value.toInt()],
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 25,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}%',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 25,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: theme.colorScheme.outline.withValues(alpha: 0.1),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barGroups: _getBarChartGroups(theme),
        ),
      ),
    );
  }

  Widget _buildPieChart(ThemeData theme) {
    return Semantics(
      label: "Graphique circulaire de la répartition des tâches par priorité",
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: _getPieChartSections(theme),
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {},
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getLineChartSpots() {
    if (_selectedPeriod == 0) {
      return [
        const FlSpot(0, 12),
        const FlSpot(1, 15),
        const FlSpot(2, 10),
        const FlSpot(3, 18),
        const FlSpot(4, 20),
        const FlSpot(5, 16),
        const FlSpot(6, 22),
      ];
    } else {
      return [
        const FlSpot(0, 65),
        const FlSpot(1, 72),
        const FlSpot(2, 68),
        const FlSpot(3, 78),
      ];
    }
  }

  List<BarChartGroupData> _getBarChartGroups(ThemeData theme) {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 75,
            color: theme.colorScheme.primary,
            width: 20,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 85,
            color: theme.colorScheme.secondary,
            width: 20,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 60,
            color: theme.colorScheme.tertiary,
            width: 20,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 90,
            color: AppTheme.getSuccessColor(theme.brightness),
            width: 20,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      ),
    ];
  }

  List<PieChartSectionData> _getPieChartSections(ThemeData theme) {
    return [
      PieChartSectionData(
        color: theme.colorScheme.error,
        value: 35,
        title: '35%',
        radius: 60,
        titleStyle: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onError,
          fontWeight: FontWeight.w600,
        ),
      ),
      PieChartSectionData(
        color: AppTheme.getWarningColor(theme.brightness),
        value: 25,
        title: '25%',
        radius: 60,
        titleStyle: theme.textTheme.labelMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      PieChartSectionData(
        color: theme.colorScheme.primary,
        value: 40,
        title: '40%',
        radius: 60,
        titleStyle: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];
  }
}

enum ChartType { line, bar, pie }
