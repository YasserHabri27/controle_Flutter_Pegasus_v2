import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// A widget displaying achievement badges with unlock status
/// Shows milestone celebrations and progress indicators
class AchievementBadgeWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final String? unlockedDate;

  const AchievementBadgeWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    this.unlockedDate,
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
          color: isUnlocked
              ? theme.colorScheme.primary.withValues(alpha: 0.5)
              : theme.colorScheme.outline.withValues(alpha: 0.2),
          width: isUnlocked ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? theme.colorScheme.primary.withValues(alpha: 0.2)
                  : theme.colorScheme.surface,
              border: Border.all(
                color: isUnlocked
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: _getIconName(icon),
                color: isUnlocked
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                size: 28,
              ),
            ),
          ),
          SizedBox(height: 1.5.h),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isUnlocked
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 0.5.h),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isUnlocked && unlockedDate != null) ...[
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.getSuccessColor(
                  theme.brightness,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Débloqué le $unlockedDate',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.getSuccessColor(theme.brightness),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getIconName(IconData icon) {
    if (icon == Icons.emoji_events) return 'emoji_events';
    if (icon == Icons.local_fire_department) return 'local_fire_department';
    if (icon == Icons.star) return 'star';
    if (icon == Icons.workspace_premium) return 'workspace_premium';
    return 'emoji_events';
  }
}
