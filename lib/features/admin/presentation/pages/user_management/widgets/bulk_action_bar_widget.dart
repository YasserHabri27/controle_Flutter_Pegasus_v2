import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../package:pegasus_app/core/app_export.dart';
import '../../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Floating action bar for bulk operations on selected users
class BulkActionBarWidget extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onDelete;
  final VoidCallback onSuspend;
  final VoidCallback onActivate;
  final VoidCallback onExport;
  final VoidCallback onCancel;

  const BulkActionBarWidget({
    super.key,
    required this.selectedCount,
    required this.onDelete,
    required this.onSuspend,
    required this.onActivate,
    required this.onExport,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'check_circle',
            color: theme.colorScheme.onPrimary,
            size: 20.sp,
          ),
          SizedBox(width: 2.w),
          Text(
            '$selectedCount sélectionné${selectedCount > 1 ? 's' : ''}',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          Spacer(),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'delete_outline',
              color: theme.colorScheme.onPrimary,
              size: 20.sp,
            ),
            onPressed: onDelete,
            tooltip: 'Supprimer',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'block',
              color: theme.colorScheme.onPrimary,
              size: 20.sp,
            ),
            onPressed: onSuspend,
            tooltip: 'Suspendre',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'check_circle_outline',
              color: theme.colorScheme.onPrimary,
              size: 20.sp,
            ),
            onPressed: onActivate,
            tooltip: 'Activer',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'download',
              color: theme.colorScheme.onPrimary,
              size: 20.sp,
            ),
            onPressed: onExport,
            tooltip: 'Exporter',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'close',
              color: theme.colorScheme.onPrimary,
              size: 20.sp,
            ),
            onPressed: onCancel,
            tooltip: 'Annuler',
          ),
        ],
      ),
    );
  }
}
