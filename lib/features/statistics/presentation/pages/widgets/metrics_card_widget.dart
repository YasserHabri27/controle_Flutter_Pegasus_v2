import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// A widget displaying key productivity metrics in a card format
/// Shows metric value, label, and trend indicator
class MetricsCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? trend;
  final bool isPositiveTrend;
  final IconData icon;

  const MetricsCardWidget({
    super.key,
    required this.title,
    required this.value,
    this.trend,
    this.isPositiveTrend = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 42.w,
      padding: EdgeInsets.all(3.w),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconWidget(
                iconName: _getIconName(icon),
                color: theme.colorScheme.primary,
                size: 20,
              ),
              if (trend != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: isPositiveTrend
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: isPositiveTrend
                            ? 'trending_up'
                            : 'trending_down',
                        color: isPositiveTrend
                            ? theme.colorScheme.primary
                            : theme.colorScheme.error,
                        size: 12,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        trend!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isPositiveTrend
                              ? theme.colorScheme.primary
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
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _getIconName(IconData icon) {
    if (icon == Icons.task_alt) return 'task_alt';
    if (icon == Icons.trending_up) return 'trending_up';
    if (icon == Icons.local_fire_department) return 'local_fire_department';
    if (icon == Icons.timer) return 'timer';
    return 'analytics';
  }
}
