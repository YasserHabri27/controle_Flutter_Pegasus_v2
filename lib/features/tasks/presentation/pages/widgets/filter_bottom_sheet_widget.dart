import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Filter bottom sheet widget for task status filtering
class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget({
    super.key,
    required this.currentFilter,
    required this.taskCounts,
    required this.onFilterSelected,
  });

  final String currentFilter;
  final Map<String, int> taskCounts;
  final ValueChanged<String> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final filters = [
      {'key': 'All', 'label': 'Toutes', 'icon': 'list'},
      {'key': 'Pending', 'label': 'En attente', 'icon': 'pending'},
      {'key': 'Completed', 'label': 'Terminées', 'icon': 'check_circle'},
      {'key': 'Overdue', 'label': 'En retard', 'icon': 'warning'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filtrer par statut',
                    style: theme.textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: colorScheme.onSurface,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Filter options
              ...filters.map((filter) {
                final key = filter['key'] as String;
                final label = filter['label'] as String;
                final icon = filter['icon'] as String;
                final count = taskCounts[key] ?? 0;
                final isSelected = currentFilter == key;

                return Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: InkWell(
                    onTap: () {
                      onFilterSelected(key);
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.outline,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: icon,
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              label,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              count.toString(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: isSelected
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
