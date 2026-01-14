import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Executive summary card widget displaying key system metrics
class ExecutiveSummaryCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String? trend;
  final bool isPositiveTrend;

  const ExecutiveSummaryCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.trend,
    this.isPositiveTrend = true,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: icon.codePoint.toString(),
                  color: iconColor,
                  size: 20,
                ),
              ),
              if (trend != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: isPositiveTrend
                        ? theme.colorScheme.tertiary.withValues(alpha: 0.1)
                        : theme.colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: isPositiveTrend
                            ? 'trending_up'
                            : 'trending_down',
                        color: isPositiveTrend
                            ? theme.colorScheme.tertiary
                            : theme.colorScheme.error,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        trend!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isPositiveTrend
                              ? theme.colorScheme.tertiary
                              : theme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
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
            subtitle,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
