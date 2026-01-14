import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../package:pegasus_app/core/app_export.dart';

/// Empty state widget for projects list
class ProjectEmptyStateWidget extends StatelessWidget {
  final bool hasActiveFilters;
  final VoidCallback? onClearFilters;

  const ProjectEmptyStateWidget({
    super.key,
    this.hasActiveFilters = false,
    this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            CustomImageWidget(
              imageUrl:
                  'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400',
              width: 60.w,
              height: 30.h,
              fit: BoxFit.contain,
              semanticLabel:
                  'Empty project illustration with clipboard and checklist on desk',
            ),

            SizedBox(height: 3.h),

            // Title
            Text(
              hasActiveFilters
                  ? 'Aucun projet trouvé'
                  : 'Créez votre premier projet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 1.h),

            // Description
            Text(
              hasActiveFilters
                  ? 'Aucun projet ne correspond à vos critères de recherche. Essayez de modifier vos filtres.'
                  : 'Organisez vos tâches en projets pour une meilleure productivité. Commencez par créer votre premier projet.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 3.h),

            // Action button
            if (hasActiveFilters && onClearFilters != null)
              ElevatedButton.icon(
                onPressed: onClearFilters,
                icon: CustomIconWidget(
                  iconName: 'clear_all',
                  color: theme.colorScheme.onPrimary,
                  size: 20,
                ),
                label: Text('Effacer les filtres'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 1.5.h,
                  ),
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  // This will be handled by the FAB in the main screen
                },
                icon: CustomIconWidget(
                  iconName: 'add',
                  color: theme.colorScheme.onPrimary,
                  size: 20,
                ),
                label: Text('Créer un projet'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 1.5.h,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
