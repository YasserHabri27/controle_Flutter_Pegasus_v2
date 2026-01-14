import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../package:pegasus_app/core/app_export.dart';
import '../../package:pegasus_app/core/widgets/custom_icon_widget.dart';
import '../../package:pegasus_app/core/widgets/custom_image_widget.dart';

/// User detail dialog showing full profile and activity history
class UserDetailDialogWidget extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback onEditDetails;
  final VoidCallback onChangeRole;
  final VoidCallback onViewActivityLog;
  final VoidCallback onAccountSettings;

  const UserDetailDialogWidget({
    super.key,
    required this.user,
    required this.onEditDetails,
    required this.onChangeRole,
    required this.onViewActivityLog,
    required this.onAccountSettings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 80.h, maxWidth: 90.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CustomImageWidget(
                      imageUrl: user['avatar'] as String,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      semanticLabel: user['avatarLabel'] as String,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          user['email'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.onPrimary.withValues(
                              alpha: 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: theme.colorScheme.onPrimary,
                      size: 20.sp,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoSection(context, 'Informations du compte', [
                      _buildInfoRow(context, 'Rôle', user['role'] as String),
                      _buildInfoRow(
                        context,
                        'Statut',
                        user['status'] as String,
                      ),
                      _buildInfoRow(
                        context,
                        'Dernière activité',
                        user['lastActive'] as String,
                      ),
                      _buildInfoRow(
                        context,
                        'Date d\'inscription',
                        user['registrationDate'] as String,
                      ),
                    ]),
                    SizedBox(height: 2.h),
                    _buildInfoSection(context, 'Statistiques des tâches', [
                      _buildInfoRow(
                        context,
                        'Tâches créées',
                        '${user['tasksCreated']}',
                      ),
                      _buildInfoRow(
                        context,
                        'Tâches terminées',
                        '${user['tasksCompleted']}',
                      ),
                      _buildInfoRow(
                        context,
                        'Workflows actifs',
                        '${user['activeWorkflows']}',
                      ),
                      _buildInfoRow(
                        context,
                        'Taux de complétion',
                        '${user['completionRate']}%',
                      ),
                    ]),
                    SizedBox(height: 2.h),
                    _buildInfoSection(context, 'Notes administratives', [
                      Text(
                        user['adminNotes'] as String,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ]),
                    SizedBox(height: 3.h),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onEditDetails,
            icon: CustomIconWidget(
              iconName: 'edit',
              color: theme.colorScheme.onPrimary,
              size: 18.sp,
            ),
            label: Text('Modifier les détails'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onChangeRole,
            icon: CustomIconWidget(
              iconName: 'admin_panel_settings',
              color: theme.colorScheme.primary,
              size: 18.sp,
            ),
            label: Text('Changer le rôle'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onViewActivityLog,
            icon: CustomIconWidget(
              iconName: 'history',
              color: theme.colorScheme.primary,
              size: 18.sp,
            ),
            label: Text('Journal d\'activité'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onAccountSettings,
            icon: CustomIconWidget(
              iconName: 'settings',
              color: theme.colorScheme.primary,
              size: 18.sp,
            ),
            label: Text('Paramètres du compte'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
            ),
          ),
        ),
      ],
    );
  }
}
