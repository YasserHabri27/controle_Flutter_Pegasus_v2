import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Primary login button widget
/// Full-width button in thumb-reachable zone with loading state
class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          disabledBackgroundColor: theme.colorScheme.onSurfaceVariant
              .withValues(alpha: 0.12),
          disabledForegroundColor: theme.colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.w),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                'Se connecter',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
      ),
    );
  }
}
