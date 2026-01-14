import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import 'package:pegasus_app/core/app_export.dart';
import '../../../../domain/entities/project_entity.dart';

/// Individual project card widget with swipe actions and progress visualization
class ProjectCardWidget extends StatelessWidget {
  final ProjectEntity project;
  final int taskCount;
  final int completedTasks;
  final double progress;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProjectCardWidget({
    super.key,
    required this.project,
    this.taskCount = 0,
    this.completedTasks = 0,
    this.progress = 0.0,
    required this.onTap,
    required this.onLongPress,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use passed progress, or entity progress if available, but usually passed is calculated
    final displayProgress = progress; 
    final status = project.status; // ProjectStatus enum

    return Dismissible(
      key: Key('project_${project.id}'),
      background: _buildSwipeBackground(
        context,
        theme,
        alignment: Alignment.centerLeft,
        color: theme.colorScheme.primary,
        icon: 'edit',
        label: 'Modifier',
      ),
      secondaryBackground: _buildSwipeBackground(
        context,
        theme,
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        icon: 'delete',
        label: 'Supprimer',
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
          return false;
        } else {
          return await _showDeleteConfirmation(context, theme);
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 2.h),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with thumbnail and title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomImageWidget(
                        imageUrl: _getThumbnailForProject(project.id),
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.cover,
                        semanticLabel: 'Project thumbnail',
                      ),
                    ),
                    SizedBox(width: 3.w),

                    // Title and status
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          _buildStatusChip(theme, status),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Description
                Text(
                  project.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 2.h),

                // Task count and progress
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'task_alt',
                      color: theme.colorScheme.primary,
                      size: 18,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '$completedTasks/$taskCount tâches',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${(displayProgress * 100).toInt()}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 1.h),

                // Progress bar
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: 0.8.h,
                  percent: displayProgress,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  progressColor: _getProgressColor(theme, displayProgress),
                  barRadius: const Radius.circular(4),
                  animation: true,
                  animationDuration: 500,
                ),

                SizedBox(height: 1.h),

                // Dates
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'calendar_today',
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      project.startDate != null ? 'Début: ${DateFormat('dd/MM/yyyy').format(project.startDate!)}' : 'Pas de date',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                    const Spacer(),
                    if (project.endDate != null)
                    Text(
                      'Fin: ${DateFormat('dd/MM/yyyy').format(project.endDate!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getThumbnailForProject(String id) {
    // Deterministic placeholder based on ID hash or last char
    final lastChar = id.isNotEmpty ? id.codeUnitAt(id.length - 1) % 5 : 0;
    switch (lastChar) {
       case 0: return 'https://images.unsplash.com/photo-1632760758480-04751e80f5b1';
       case 1: return 'https://img.rocket.new/generatedImages/rocket_gen_img_113617219-1764737686388.png';
       case 2: return 'https://img.rocket.new/generatedImages/rocket_gen_img_13526d7ce-1766477206821.png';
       case 3: return 'https://img.rocket.new/generatedImages/rocket_gen_img_1c6a65c22-1765804100175.png';
       case 4: return 'https://images.unsplash.com/photo-1595850434866-49af768f27c3';
       default: return 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40';
    }
  }

  Widget _buildStatusChip(ThemeData theme, ProjectStatus status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case ProjectStatus.active:
      case ProjectStatus.inProgress:
        backgroundColor = theme.colorScheme.primary.withValues(alpha: 0.1);
        textColor = theme.colorScheme.primary;
        label = 'Actif';
        break;
      case ProjectStatus.completed:
        backgroundColor = AppTheme.getSuccessColor(
          theme.brightness,
        ).withValues(alpha: 0.1);
        textColor = AppTheme.getSuccessColor(theme.brightness);
        label = 'Terminé';
        break;
      case ProjectStatus.archived:
      case ProjectStatus.cancelled:
        backgroundColor = theme.colorScheme.onSurfaceVariant.withValues(
          alpha: 0.1,
        );
        textColor = theme.colorScheme.onSurfaceVariant;
        label = 'Archivé';
        break;
      case ProjectStatus.todo:
      default:
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        textColor = theme.colorScheme.onSurfaceVariant;
        label = 'À faire';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getProgressColor(ThemeData theme, double progress) {
    if (progress >= 1.0) {
      return AppTheme.getSuccessColor(theme.brightness);
    } else if (progress >= 0.5) {
      return theme.colorScheme.primary;
    } else {
      return AppTheme.getWarningColor(theme.brightness);
    }
  }

  Widget _buildSwipeBackground(
    BuildContext context,
    ThemeData theme, {
    required Alignment alignment,
    required Color color,
    required String icon,
    required String label,
  }) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(iconName: icon, color: Colors.white, size: 24),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(
    BuildContext context,
    ThemeData theme,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Supprimer le projet',
              style: theme.textTheme.titleLarge,
            ),
            content: Text(
              'Êtes-vous sûr de vouloir supprimer ce projet ? Cette action est irréversible.',
              style: theme.textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Annuler',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Supprimer',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
