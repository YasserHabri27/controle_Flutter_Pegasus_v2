import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Chart card widget for displaying various metrics with interactive charts
class MetricChartCardWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>> chartData;
  final String chartType;

  const MetricChartCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.chartData,
    required this.chartType,
  });

  @override
  State<MetricChartCardWidget> createState() => _MetricChartCardWidgetState();
}

class _MetricChartCardWidgetState extends State<MetricChartCardWidget> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      widget.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: CustomIconWidget(
                  iconName: 'more_vert',
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 3.h),
          SizedBox(
            height: 25.h,
            child: widget.chartType == 'bar'
                ? _buildBarChart(theme)
                : widget.chartType == 'line'
                ? _buildLineChart(theme)
                : _buildPieChart(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(ThemeData theme) {
    return Semantics(
      label: "${widget.title} Bar Chart",
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY:
              widget.chartData
                  .map((e) => (e['value'] as num).toDouble())
                  .reduce((a, b) => a > b ? a : b) *
              1.2,
          barTouchData: BarTouchData(
            enabled: true,
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (barTouchResponse != null &&
                    barTouchResponse.spot != null &&
                    event is FlTapUpEvent) {
                  _touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                } else {
                  _touchedIndex = -1;
                }
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 &&
                      value.toInt() < widget.chartData.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Text(
                        widget.chartData[value.toInt()]['label'] as String,
                        style: theme.textTheme.labelSmall,
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
                reservedSize: 10.w,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: theme.textTheme.labelSmall,
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
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
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            widget.chartData.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: (widget.chartData[index]['value'] as num).toDouble(),
                  color: _touchedIndex == index
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withValues(alpha: 0.7),
                  width: 8.w,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart(ThemeData theme) {
    return Semantics(
      label: "${widget.title} Line Chart",
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
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 &&
                      value.toInt() < widget.chartData.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Text(
                        widget.chartData[value.toInt()]['label'] as String,
                        style: theme.textTheme.labelSmall,
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
                reservedSize: 10.w,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: theme.textTheme.labelSmall,
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                widget.chartData.length,
                (index) => FlSpot(
                  index.toDouble(),
                  (widget.chartData[index]['value'] as num).toDouble(),
                ),
              ),
              isCurved: true,
              color: theme.colorScheme.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
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

  Widget _buildPieChart(ThemeData theme) {
    return Semantics(
      label: "${widget.title} Pie Chart",
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (pieTouchResponse != null &&
                    pieTouchResponse.touchedSection != null &&
                    event is FlTapUpEvent) {
                  _touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                } else {
                  _touchedIndex = -1;
                }
              });
            },
          ),
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 15.w,
          sections: List.generate(widget.chartData.length, (index) {
            final isTouched = index == _touchedIndex;
            final radius = isTouched ? 18.w : 15.w;
            final colors = [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
              theme.colorScheme.tertiary,
              theme.colorScheme.error,
            ];
            return PieChartSectionData(
              color: colors[index % colors.length],
              value: (widget.chartData[index]['value'] as num).toDouble(),
              title: '${widget.chartData[index]['value']}%',
              radius: radius,
              titleStyle: theme.textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            );
          }),
        ),
      ),
    );
  }
}
