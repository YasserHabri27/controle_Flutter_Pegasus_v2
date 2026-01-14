import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Task card widget displaying task information with priority badge and completion checkbox
class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onTap,
    required this.onLongPress,
    required this.onCheckboxChanged,
  });

  final Map<String, dynamic> task;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final ValueChanged<bool?> onCheckboxChanged;

  Color _getPriorityColor(String priority, ColorScheme colorScheme) {
    switch (priority) {
      case 'High':
        return colorScheme.error;
      case 'Medium':
        return const Color(0xFFFF9800);
      case 'Low':
        return colorScheme.secondary;
      default:
        return colorScheme.onSurfaceVariant;
    }
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case 'High':
        return 'Haute';
      case 'Medium':
        return 'Moyenne';
      case 'Low':
        return 'Basse';
      default:
        return priority;
    }
  }

  bool _isOverdue(DateTime dueDate, bool isCompleted) {
    return !isCompleted && dueDate.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final title = task["title"] as String;
    final description = task["description"] as String;
    final priority = task["priority"] as String;
    final dueDate = task["dueDate"] as DateTime;
    final isCompleted = task["isCompleted"] as bool;
    final isOverdue = _isOverdue(dueDate, isCompleted);

    final priorityColor = _getPriorityColor(priority, colorScheme);
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOverdue
            ? BorderSide(color: colorScheme.error, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and checkbox row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isCompleted,
                    onChanged: onCheckboxChanged,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            decoration: isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: isCompleted
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Priority badge and due date row
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: priorityColor, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'flag',
                          color: priorityColor,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          _getPriorityLabel(priority),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: priorityColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'calendar_today',
                        color: isOverdue
                            ? colorScheme.error
                            : colorScheme.onSurfaceVariant,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        dateFormatter.format(dueDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isOverdue
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                          fontWeight: isOverdue
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (isOverdue) ...[
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.w,
                    vertical: 0.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'warning',
                        color: colorScheme.error,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'En retard',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
