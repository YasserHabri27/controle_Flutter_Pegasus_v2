import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Performance benchmark comparison widget
class PerformanceBenchmarkWidget extends StatelessWidget {
  final List<Map<String, dynamic>> benchmarkData;

  const PerformanceBenchmarkWidget({super.key, required this.benchmarkData});

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
          Text(
            'Références de performance',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Comparaison avec les données historiques',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 3.h),
          ...List.generate(
            benchmarkData.length,
            (index) =>
                _buildBenchmarkItem(context, theme, benchmarkData[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildBenchmarkItem(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> benchmark,
  ) {
    final currentValue = (benchmark['current'] as num).toDouble();
    final previousValue = (benchmark['previous'] as num).toDouble();
    final change = ((currentValue - previousValue) / previousValue * 100);
    final isPositive = change >= 0;

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
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
                    benchmark['metric'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? AppTheme.getSuccessColor(
                            theme.brightness,
                          ).withValues(alpha: 0.1)
                        : theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: isPositive
                            ? 'arrow_upward'
                            : 'arrow_downward',
                        color: isPositive
                            ? AppTheme.getSuccessColor(theme.brightness)
                            : theme.colorScheme.error,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${change.abs().toStringAsFixed(1)}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isPositive
                              ? AppTheme.getSuccessColor(theme.brightness)
                              : theme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Actuel',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        currentValue.toStringAsFixed(0),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 5.h,
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Précédent',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        previousValue.toStringAsFixed(0),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
