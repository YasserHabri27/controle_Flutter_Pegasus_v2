import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/theme/app_theme.dart';

/// System health indicator widget showing service status
class SystemHealthIndicatorWidget extends StatelessWidget {
  final String serviceName;
  final String status;
  final bool isHealthy;
  final String? details;

  const SystemHealthIndicatorWidget({
    super.key,
    required this.serviceName,
    required this.status,
    required this.isHealthy,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(3.w),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHealthy
              ? AppTheme.getSuccessColor(
                  theme.brightness,
                ).withValues(alpha: 0.3)
              : AppTheme.getWarningColor(
                  theme.brightness,
                ).withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: isHealthy
                  ? AppTheme.getSuccessColor(
                      theme.brightness,
                    ).withValues(alpha: 0.1)
                  : AppTheme.getWarningColor(
                      theme.brightness,
                    ).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  color: isHealthy
                      ? AppTheme.getSuccessColor(theme.brightness)
                      : AppTheme.getWarningColor(theme.brightness),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  status,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isHealthy
                        ? AppTheme.getSuccessColor(theme.brightness)
                        : AppTheme.getWarningColor(theme.brightness),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (details != null) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    details!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
