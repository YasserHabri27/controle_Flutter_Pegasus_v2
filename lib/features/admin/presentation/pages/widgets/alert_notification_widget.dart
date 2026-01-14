import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Alert notification widget for admin attention items
class AlertNotificationWidget extends StatelessWidget {
  final String title;
  final String description;
  final String timestamp;
  final IconData icon;
  final Color alertColor;
  final VoidCallback? onTap;

  const AlertNotificationWidget({
    super.key,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.alertColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(3.w),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: alertColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: alertColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: alertColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon.codePoint.toString(),
                color: alertColor,
                size: 20,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: alertColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    timestamp,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              CustomIconWidget(
                iconName: 'chevron_right',
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
