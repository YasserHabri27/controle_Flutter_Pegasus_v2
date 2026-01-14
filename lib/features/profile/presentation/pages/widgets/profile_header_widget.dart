import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';
import '../../../../presentation/widgets/custom_image_widget.dart';

/// Profile header widget displaying user avatar, name, and role badge
/// Implements Contemporary Productive Minimalism with touch-optimized edit controls
class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    required this.userName,
    required this.userRole,
    required this.avatarUrl,
    required this.onEditPhoto,
  });

  final String userName;
  final String userRole;
  final String avatarUrl;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: colorScheme.outline, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Avatar with edit button
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary, width: 2),
                ),
                child: ClipOval(
                  child: CustomImageWidget(
                    imageUrl: avatarUrl,
                    width: 25.w,
                    height: 25.w,
                    fit: BoxFit.cover,
                    semanticLabel: "Profile photo of $userName",
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: InkWell(
                  onTap: onEditPhoto,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.surface, width: 2),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'camera_alt',
                        color: colorScheme.onPrimary,
                        size: 4.w,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // User name
          Text(
            userName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 0.5.h),
          // Role badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              userRole,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
