import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Logo section widget displaying the Pegasus brand logo
/// Positioned at the top of the login screen for brand recognition
class LogoSectionWidget extends StatelessWidget {
  const LogoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pegasus Logo
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/image-1767396189878.png',
                  width: 25.w,
                  height: 25.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return CustomIconWidget(
                      iconName: 'flight',
                      size: 15.w,
                      color: theme.colorScheme.primary,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          // App Name
          Text(
            'Pegasus',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.5.h),
          // Tagline
          Text(
            'Gestionnaire de flux de travail',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
