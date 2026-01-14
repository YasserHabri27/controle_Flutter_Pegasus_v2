import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Register link widget at bottom of screen
/// Provides easy access to account creation
class RegisterLinkWidget extends StatelessWidget {
  const RegisterLinkWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Nouvel utilisateur? ',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(1.w),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            child: Text(
              'S\'inscrire',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
