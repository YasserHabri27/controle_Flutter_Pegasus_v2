import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Notification settings widget with granular controls
/// Implements toggle switches for different notification types
class NotificationSettingsWidget extends StatelessWidget {
  const NotificationSettingsWidget({
    super.key,
    required this.taskReminders,
    required this.workflowUpdates,
    required this.dailyDigest,
    required this.onTaskRemindersChanged,
    required this.onWorkflowUpdatesChanged,
    required this.onDailyDigestChanged,
  });

  final bool taskReminders;
  final bool workflowUpdates;
  final bool dailyDigest;
  final ValueChanged<bool> onTaskRemindersChanged;
  final ValueChanged<bool> onWorkflowUpdatesChanged;
  final ValueChanged<bool> onDailyDigestChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        children: [
          _NotificationToggleWidget(
            title: 'Rappels de tâches',
            subtitle: 'Recevoir des notifications pour les tâches à venir',
            value: taskReminders,
            onChanged: onTaskRemindersChanged,
            showDivider: true,
          ),
          _NotificationToggleWidget(
            title: 'Mises à jour du workflow',
            subtitle: 'Notifications sur les changements de workflow',
            value: workflowUpdates,
            onChanged: onWorkflowUpdatesChanged,
            showDivider: true,
          ),
          _NotificationToggleWidget(
            title: 'Résumé quotidien',
            subtitle: 'Rapport quotidien de productivité',
            value: dailyDigest,
            onChanged: onDailyDigestChanged,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _NotificationToggleWidget extends StatelessWidget {
  const _NotificationToggleWidget({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.showDivider,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(value: value, onChanged: onChanged),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Divider(height: 1, thickness: 1, color: colorScheme.outline),
          ),
      ],
    );
  }
}
