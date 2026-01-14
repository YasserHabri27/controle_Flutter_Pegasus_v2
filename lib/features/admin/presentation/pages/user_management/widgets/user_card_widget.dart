import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../package:pegasus_app/core/app_export.dart';
import '../../package:pegasus_app/core/widgets/custom_icon_widget.dart';
import '../../package:pegasus_app/core/widgets/custom_image_widget.dart';

/// User card widget with swipe actions and selection mode
class UserCardWidget extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onViewProfile;
  final VoidCallback onSendMessage;
  final VoidCallback onGenerateReport;
  final VoidCallback onSuspend;
  final VoidCallback onResetPassword;

  const UserCardWidget({
    super.key,
    required this.user,
    required this.isSelected,
    required this.isSelectionMode,
    required this.onTap,
    required this.onLongPress,
    required this.onCheckboxChanged,
    required this.onViewProfile,
    required this.onSendMessage,
    required this.onGenerateReport,
    required this.onSuspend,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Slidable(
      key: ValueKey(user['id']),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onViewProfile(),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            icon: Icons.person_outline,
            label: 'Profil',
          ),
          SlidableAction(
            onPressed: (context) => onSendMessage(),
            backgroundColor: theme.colorScheme.secondary,
            foregroundColor: theme.colorScheme.onSecondary,
            icon: Icons.message_outlined,
            label: 'Message',
          ),
          SlidableAction(
            onPressed: (context) => onGenerateReport(),
            backgroundColor: theme.colorScheme.tertiary,
            foregroundColor: theme.colorScheme.onTertiary,
            icon: Icons.description_outlined,
            label: 'Rapport',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onSuspend(),
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            icon: Icons.block_outlined,
            label: 'Suspendre',
          ),
          SlidableAction(
            onPressed: (context) => onResetPassword(),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.lock_reset_outlined,
            label: 'Réinitialiser',
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              children: [
                if (isSelectionMode)
                  Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: Checkbox(
                      value: isSelected,
                      onChanged: onCheckboxChanged,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CustomImageWidget(
                    imageUrl: user['avatar'] as String,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    semanticLabel: user['avatarLabel'] as String,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user['name'] as String,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getRoleBadgeColor(
                                user['role'] as String,
                                theme,
                              ).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              user['role'] as String,
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: _getRoleBadgeColor(
                                  user['role'] as String,
                                  theme,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        user['email'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'access_time',
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 12.sp,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            'Dernière activité: ${user['lastActive']}',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                user['status'] as String,
                                theme,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            user['status'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: _getStatusColor(
                                user['status'] as String,
                                theme,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRoleBadgeColor(String role, ThemeData theme) {
    return role == 'Admin'
        ? theme.colorScheme.secondary
        : theme.colorScheme.primary;
  }

  Color _getStatusColor(String status, ThemeData theme) {
    switch (status) {
      case 'Actif':
        return Colors.green;
      case 'Suspendu':
        return theme.colorScheme.error;
      case 'Nouveau':
        return theme.colorScheme.tertiary;
      default:
        return theme.colorScheme.onSurfaceVariant;
    }
  }
}
