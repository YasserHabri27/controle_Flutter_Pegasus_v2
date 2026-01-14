import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Quick action button widget for admin operations
class QuickActionButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const QuickActionButtonWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: (backgroundColor ?? theme.colorScheme.primary).withValues(
                alpha: 0.3,
              ),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: icon.codePoint.toString(),
              color: iconColor ?? theme.colorScheme.onPrimary,
              size: 20,
            ),
            SizedBox(width: 2.w),
            Flexible(
              child: Text(
                label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: iconColor ?? theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
