import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_image_widget.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Empty state widget displayed when no tasks are available
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.hasSearchQuery,
    required this.onCreateTask,
  });

  final bool hasSearchQuery;
  final VoidCallback onCreateTask;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageWidget(
              imageUrl:
                  'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=400',
              width: 60.w,
              height: 30.h,
              fit: BoxFit.contain,
              semanticLabel:
                  'Empty checklist illustration with clipboard and checkmarks on a clean white background',
            ),

            SizedBox(height: 3.h),

            Text(
              hasSearchQuery
                  ? 'Aucune tâche trouvée'
                  : 'Aucune tâche disponible',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 1.h),

            Text(
              hasSearchQuery
                  ? 'Essayez de modifier vos critères de recherche ou de filtrage'
                  : 'Commencez par créer votre première tâche pour organiser votre travail',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            if (!hasSearchQuery) ...[
              SizedBox(height: 4.h),

              ElevatedButton.icon(
                onPressed: onCreateTask,
                icon: CustomIconWidget(
                  iconName: 'add',
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
                label: const Text('Créer votre première tâche'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 1.5.h,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
