import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Settings section widget with grouped list items
/// Implements Material Design 3 list styling with proper spacing
class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              top: BorderSide(color: colorScheme.outline, width: 1),
              bottom: BorderSide(color: colorScheme.outline, width: 1),
            ),
          ),
          child: Column(children: children),
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
