import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';
import '../package:pegasus_app/core/theme/app_theme.dart';

/// Statistics card widget displaying key metrics with trend indicators
class StatisticsCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final IconData icon;
  final Color? backgroundColor;

  const StatisticsCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.trend,
    required this.isPositive,
    required this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 42.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
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
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: icon.codePoint.toString(),
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppTheme.getSuccessColor(
                          theme.brightness,
                        ).withValues(alpha: 0.1)
                      : AppTheme.getWarningColor(
                          theme.brightness,
                        ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: isPositive ? 'trending_up' : 'trending_down',
                      color: isPositive
                          ? AppTheme.getSuccessColor(theme.brightness)
                          : AppTheme.getWarningColor(theme.brightness),
                      size: 12,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      trend,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isPositive
                            ? AppTheme.getSuccessColor(theme.brightness)
                            : AppTheme.getWarningColor(theme.brightness),
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
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
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
