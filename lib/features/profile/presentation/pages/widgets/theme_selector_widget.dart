import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Theme selector widget with Light, Dark, and System options
/// Implements immediate theme switching with smooth transitions
class ThemeSelectorWidget extends StatelessWidget {
  const ThemeSelectorWidget({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  final String currentTheme;
  final ValueChanged<String> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sélection du thème',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _ThemeOptionWidget(
                  label: 'Clair',
                  icon: 'light_mode',
                  isSelected: currentTheme == 'light',
                  onTap: () => onThemeChanged('light'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _ThemeOptionWidget(
                  label: 'Sombre',
                  icon: 'dark_mode',
                  isSelected: currentTheme == 'dark',
                  onTap: () => onThemeChanged('dark'),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _ThemeOptionWidget(
                  label: 'Système',
                  icon: 'settings_brightness',
                  isSelected: currentTheme == 'system',
                  onTap: () => onThemeChanged('system'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOptionWidget extends StatelessWidget {
  const _ThemeOptionWidget({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            CustomIconWidget(
              iconName: icon,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
