import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../package:pegasus_app/core/app_export.dart';
import '../../package:pegasus_app/core/widgets/custom_icon_widget.dart';

/// Search bar widget for filtering users by name, email, or role
class UserSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const UserSearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: theme.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: 'Rechercher par nom, email ou rôle...',
          hintStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: theme.colorScheme.onSurfaceVariant,
              size: 20.sp,
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: CustomIconWidget(
                    iconName: 'clear',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20.sp,
                  ),
                  onPressed: onClear,
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.outline, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.outline, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: 1.5.h,
          ),
        ),
      ),
    );
  }
}
