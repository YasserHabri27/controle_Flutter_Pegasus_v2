import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../package:pegasus_app/core/app_export.dart';

/// Filter chips for user status, role, and registration date
class FilterChipsWidget extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterChipsWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filters = [
      {'label': 'Tous', 'value': 'all'},
      {'label': 'Actifs', 'value': 'active'},
      {'label': 'Suspendus', 'value': 'suspended'},
      {'label': 'Nouveaux', 'value': 'new'},
      {'label': 'Utilisateurs', 'value': 'user'},
      {'label': 'Admins', 'value': 'admin'},
    ];

    return Container(
      height: 6.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => SizedBox(width: 2.w),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter['value'];

          return FilterChip(
            label: Text(
              filter['label']!,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                onFilterChanged(filter['value']!);
              }
            },
            backgroundColor: theme.colorScheme.surface,
            selectedColor: theme.colorScheme.primary,
            checkmarkColor: theme.colorScheme.onPrimary,
            side: BorderSide(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          );
        },
      ),
    );
  }
}
