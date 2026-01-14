import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// User adoption funnel widget showing conversion metrics
class UserAdoptionFunnelWidget extends StatelessWidget {
  final List<Map<String, dynamic>> funnelData;

  const UserAdoptionFunnelWidget({super.key, required this.funnelData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
            'Entonnoir d\'adoption des utilisateurs',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Conversion de l\'inscription à l\'utilisateur actif',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 3.h),
          ...List.generate(
            funnelData.length,
            (index) => _buildFunnelStage(context, theme, index),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(BuildContext context, ThemeData theme, int index) {
    final stage = funnelData[index];
    final percentage = (stage['percentage'] as num).toDouble();
    final maxWidth = 90.w - 8.w;
    final stageWidth = maxWidth * (percentage / 100);

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  stage['stage'] as String,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${stage['count']} (${percentage.toStringAsFixed(1)}%)',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Stack(
            children: [
              Container(
                height: 1.5.h,
                width: maxWidth,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Container(
                height: 1.5.h,
                width: stageWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
