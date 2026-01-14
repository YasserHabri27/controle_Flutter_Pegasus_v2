import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Forgot password link widget
/// Positioned right-aligned under password field
class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(1.w),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Text(
            'Mot de passe oublié?',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
