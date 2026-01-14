import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Alert system widget for highlighting important system issues
class AlertSystemWidget extends StatelessWidget {
  final List<Map<String, dynamic>> alerts;

  const AlertSystemWidget({super.key, required this.alerts});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return alerts.isEmpty
        ? const SizedBox.shrink()
        : Container(
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
                  children: [
                    CustomIconWidget(
                      iconName: 'warning',
                      color: AppTheme.getWarningColor(theme.brightness),
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Alertes système',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${alerts.length} problème${alerts.length > 1 ? 's' : ''} nécessitant une attention',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 2.h),
                ...List.generate(
                  alerts.length,
                  (index) => _buildAlertItem(context, theme, alerts[index]),
                ),
              ],
            ),
          );
  }

  Widget _buildAlertItem(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> alert,
  ) {
    final severity = alert['severity'] as String;
    Color alertColor;
    IconData alertIcon;

    switch (severity) {
      case 'critical':
        alertColor = theme.colorScheme.error;
        alertIcon = Icons.error;
        break;
      case 'warning':
        alertColor = AppTheme.getWarningColor(theme.brightness);
        alertIcon = Icons.warning;
        break;
      default:
        alertColor = theme.colorScheme.tertiary;
        alertIcon = Icons.info;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: alertColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: alertColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(1.5.w),
              decoration: BoxDecoration(
                color: alertColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: CustomIconWidget(
                iconName: alertIcon.codePoint.toString(),
                color: alertColor,
                size: 18,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert['title'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: alertColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    alert['description'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    alert['timestamp'] as String,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
