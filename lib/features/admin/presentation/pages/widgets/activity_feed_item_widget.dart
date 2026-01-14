import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';

/// Activity feed item widget displaying recent user actions
class ActivityFeedItemWidget extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String userAvatarSemanticLabel;
  final String action;
  final String timestamp;
  final IconData actionIcon;
  final Color actionColor;

  const ActivityFeedItemWidget({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.userAvatarSemanticLabel,
    required this.action,
    required this.timestamp,
    required this.actionIcon,
    required this.actionColor,
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
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: userAvatar,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
                semanticLabel: userAvatarSemanticLabel,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        userName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: actionColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CustomIconWidget(
                        iconName: actionIcon.codePoint.toString(),
                        color: actionColor,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  action,
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
        ],
      ),
    );
  }
}
