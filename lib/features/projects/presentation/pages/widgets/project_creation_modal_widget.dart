import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';

/// Full-screen modal for project creation with task association
class ProjectCreationModalWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onProjectCreated;

  const ProjectCreationModalWidget({
    super.key,
    required this.onProjectCreated,
  });

  @override
  State<ProjectCreationModalWidget> createState() =>
      _ProjectCreationModalWidgetState();
}

class _ProjectCreationModalWidgetState
    extends State<ProjectCreationModalWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();

  String _searchQuery = '';
  final Set<int> _selectedTaskIds = {};

  // Mock available tasks
  final List<Map<String, dynamic>> _availableTasks = [
    {
      "id": 1,
      "title": "Conception de l'interface utilisateur",
      "priority": "high",
      "dueDate": "10/01/2026",
    },
    {
      "id": 2,
      "title": "Développement du backend API",
      "priority": "high",
      "dueDate": "15/01/2026",
    },
    {
      "id": 3,
      "title": "Tests unitaires et intégration",
      "priority": "medium",
      "dueDate": "20/01/2026",
    },
    {
      "id": 4,
      "title": "Création du contenu marketing",
      "priority": "medium",
      "dueDate": "12/01/2026",
    },
    {
      "id": 5,
      "title": "Analyse des performances",
      "priority": "low",
      "dueDate": "25/01/2026",
    },
    {
      "id": 6,
      "title": "Documentation technique",
      "priority": "low",
      "dueDate": "30/01/2026",
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredTasks {
    if (_searchQuery.isEmpty) {
      return _availableTasks;
    }
    return _availableTasks.where((task) {
      final title = (task['title'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query);
    }).toList();
  }

  void _handleCreateProject() {
    if (_formKey.currentState!.validate()) {
      final projectData = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "name": _nameController.text,
        "description": _descriptionController.text,
        "taskCount": _selectedTaskIds.length,
        "completedTasks": 0,
        "progress": 0.0,
        "status": "active",
        "thumbnail":
            "https://img.rocket.new/generatedImages/rocket_gen_img_1a3218649-1767106589690.png",
        "semanticLabel":
            "Newly created project with tasks and planning documents",
        "createdDate":
            "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}",
        "lastModified":
            "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}",
      };

      widget.onProjectCreated(projectData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredTasks = _filteredTasks;

    return Container(
      height: 95.h,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: CustomIconWidget(
              iconName: 'close',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Nouveau Projet', style: theme.textTheme.titleLarge),
          actions: [
            TextButton(
              onPressed: _handleCreateProject,
              child: Text(
                'Créer',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            children: [
              // Name field
              TextFormField(
                controller: _nameController,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  labelText: 'Nom du projet',
                  hintText: 'Ex: Projet de développement mobile',
                  prefixIcon: CustomIconWidget(
                    iconName: 'account_tree',
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),

              SizedBox(height: 2.h),

              // Description field
              TextFormField(
                controller: _descriptionController,
                style: theme.textTheme.bodyLarge,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Décrivez votre projet...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: CustomIconWidget(
                      iconName: 'description',
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),

              SizedBox(height: 3.h),

              // Task association section
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'task_alt',
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Associer des tâches',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_selectedTaskIds.length} sélectionnée(s)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 1.h),

              // Search field
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Rechercher des tâches...',
                  prefixIcon: CustomIconWidget(
                    iconName: 'search',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: CustomIconWidget(
                            iconName: 'close',
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.5.h,
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // Task list
              ...filteredTasks.map((task) {
                final isSelected = _selectedTaskIds.contains(task['id']);
                final priority = task['priority'] as String;

                return Card(
                  margin: EdgeInsets.only(bottom: 1.h),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedTaskIds.add(task['id'] as int);
                        } else {
                          _selectedTaskIds.remove(task['id']);
                        }
                      });
                    },
                    title: Text(
                      task['title'] as String,
                      style: theme.textTheme.bodyMedium,
                    ),
                    subtitle: Row(
                      children: [
                        _buildPriorityChip(theme, priority),
                        SizedBox(width: 2.w),
                        CustomIconWidget(
                          iconName: 'calendar_today',
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          task['dueDate'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              }).toList(),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityChip(ThemeData theme, String priority) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (priority) {
      case 'high':
        backgroundColor = theme.colorScheme.error.withValues(alpha: 0.1);
        textColor = theme.colorScheme.error;
        label = 'Haute';
        break;
      case 'medium':
        backgroundColor = AppTheme.getWarningColor(
          theme.brightness,
        ).withValues(alpha: 0.1);
        textColor = AppTheme.getWarningColor(theme.brightness);
        label = 'Moyenne';
        break;
      case 'low':
        backgroundColor = AppTheme.getSuccessColor(
          theme.brightness,
        ).withValues(alpha: 0.1);
        textColor = AppTheme.getSuccessColor(theme.brightness);
        label = 'Basse';
        break;
      default:
        backgroundColor = theme.colorScheme.surfaceContainerHighest;
        textColor = theme.colorScheme.onSurfaceVariant;
        label = priority;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 9.sp,
        ),
      ),
    );
  }
}
