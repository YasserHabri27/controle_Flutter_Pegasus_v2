import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Individual settings item with icon, title, subtitle, and trailing widget
/// Supports navigation, toggle switches, and inline editing
class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: icon,
                      color: colorScheme.primary,
                      size: 5.w,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 0.5.h),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Trailing widget
                if (trailing != null)
                  trailing!
                else if (onTap != null)
                  CustomIconWidget(
                    iconName: 'chevron_right',
                    color: colorScheme.onSurfaceVariant,
                    size: 5.w,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.only(left: 19.w),
            child: Divider(height: 1, thickness: 1, color: colorScheme.outline),
          ),
      ],
    );
  }
}
