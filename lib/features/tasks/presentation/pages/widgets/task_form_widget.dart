import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../package:pegasus_app/core/app_export.dart';
import '../../../../presentation/widgets/custom_icon_widget.dart';

/// Task creation and editing form widget
class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key, this.task, required this.onSave});

  final Map<String, dynamic>? task;
  final Function(Map<String, dynamic>) onSave;

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedPriority = 'Medium';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!["title"] as String;
      _descriptionController.text = widget.task!["description"] as String;
      _selectedPriority = widget.task!["priority"] as String;
      _selectedDate = widget.task!["dueDate"] as DateTime;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('fr', 'FR'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final taskData = {
        "title": _titleController.text.trim(),
        "description": _descriptionController.text.trim(),
        "priority": _selectedPriority,
        "dueDate": _selectedDate,
      };

      widget.onSave(taskData);
      Navigator.pop(context);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final isEditing = widget.task != null;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            right: 4.w,
            top: 2.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEditing ? 'Modifier la tâche' : 'Nouvelle tâche',
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

                  SizedBox(height: 3.h),

                  // Title field
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Titre *',
                      hintText: 'Entrez le titre de la tâche',
                      prefixIcon: CustomIconWidget(
                        iconName: 'title',
                        color: colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Le titre est obligatoire';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 2.h),

                  // Description field
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description *',
                      hintText: 'Entrez la description de la tâche',
                      prefixIcon: CustomIconWidget(
                        iconName: 'description',
                        color: colorScheme.primary,
                        size: 20,
                      ),
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                    maxLength: 500,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La description est obligatoire';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 2.h),

                  // Priority picker
                  Text('Priorité *', style: theme.textTheme.titleSmall),
                  SizedBox(height: 1.h),
                  Row(
                    children: ['High', 'Medium', 'Low'].map((priority) {
                      final isSelected = _selectedPriority == priority;
                      final priorityColor = _getPriorityColor(
                        priority,
                        colorScheme,
                      );
                      final label = priority == 'High'
                          ? 'Haute'
                          : priority == 'Medium'
                          ? 'Moyenne'
                          : 'Basse';

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPriority = priority;
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 1.5.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? priorityColor.withValues(alpha: 0.2)
                                    : colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? priorityColor
                                      : colorScheme.outline,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'flag',
                                    color: priorityColor,
                                    size: 24,
                                  ),
                                  SizedBox(height: 0.5.h),
                                  Text(
                                    label,
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                          color: priorityColor,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 2.h),

                  // Due date picker
                  Text('Date d\'échéance *', style: theme.textTheme.titleSmall),
                  SizedBox(height: 1.h),
                  InkWell(
                    onTap: () => _selectDate(context),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.outline),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'calendar_today',
                            color: colorScheme.primary,
                            size: 20,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            dateFormatter.format(_selectedDate),
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          CustomIconWidget(
                            iconName: 'arrow_drop_down',
                            color: colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Annuler'),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveTask,
                          child: Text(isEditing ? 'Mettre à jour' : 'Créer'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
