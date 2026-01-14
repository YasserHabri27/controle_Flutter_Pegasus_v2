import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Feature usage analytics card widget
class FeatureUsageCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> featureData;

  const FeatureUsageCardWidget({super.key, required this.featureData});

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
            'Analyse d\'utilisation des fonctionnalités',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            'Fonctionnalités les plus populaires',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 3.h),
          ...List.generate(
            featureData.length,
            (index) => _buildFeatureItem(context, theme, featureData[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    ThemeData theme,
    Map<String, dynamic> feature,
  ) {
    final usagePercentage = (feature['usage'] as num).toDouble();
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      AppTheme.getAccentColor(theme.brightness),
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: colors[featureData.indexOf(feature) % colors.length]
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomIconWidget(
              iconName: feature['icon'] as String,
              color: colors[featureData.indexOf(feature) % colors.length],
              size: 20,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        feature['name'] as String,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${usagePercentage.toStringAsFixed(0)}%',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            colors[featureData.indexOf(feature) %
                                colors.length],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${feature['users']} utilisateurs',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 1.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: usagePercentage / 100,
                    backgroundColor: theme.colorScheme.outline.withValues(
                      alpha: 0.1,
                    ),
                    color: colors[featureData.indexOf(feature) % colors.length],
                    minHeight: 0.8.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
