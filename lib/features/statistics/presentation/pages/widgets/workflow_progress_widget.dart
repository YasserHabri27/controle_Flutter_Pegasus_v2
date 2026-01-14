import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../../../theme/app_theme.dart';

/// A widget displaying workflow progress with horizontal progress bars
/// Shows completion percentage and status indicators
class WorkflowProgressWidget extends StatelessWidget {
  final List<Map<String, dynamic>> workflows;

  const WorkflowProgressWidget({super.key, required this.workflows});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progression des workflows',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workflows.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final workflow = workflows[index];
              return _buildWorkflowItem(workflow, theme);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowItem(Map<String, dynamic> workflow, ThemeData theme) {
    final name = workflow['name'] as String;
    final progress = workflow['progress'] as double;
    final tasksCompleted = workflow['tasksCompleted'] as int;
    final totalTasks = workflow['totalTasks'] as int;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${progress.toInt()}%',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress / 100,
            minHeight: 8,
            backgroundColor: theme.colorScheme.surface,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(progress, theme),
            ),
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          '$tasksCompleted sur $totalTasks tâches complétées',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress, ThemeData theme) {
    if (progress >= 75) {
      return AppTheme.getSuccessColor(theme.brightness);
    } else if (progress >= 50) {
      return theme.colorScheme.primary;
    } else if (progress >= 25) {
      return AppTheme.getWarningColor(theme.brightness);
    } else {
      return theme.colorScheme.error;
    }
  }
}
