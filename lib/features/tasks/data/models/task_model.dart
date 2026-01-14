import 'package:hive/hive.dart';
import '../../domain/entities/task_entity.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends TaskEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool isCompleted;
  @HiveField(4)
  final DateTime dueDate;
  @HiveField(5)
  final String priority;
  @HiveField(6)
  final String projectId;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
    required this.priority,
    required this.projectId,
  }) : super(
          id: id,
          title: title,
          description: description,
          isCompleted: isCompleted,
          dueDate: dueDate,
          priority: priority,
          projectId: projectId,
        );

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      dueDate: entity.dueDate,
      priority: entity.priority,
      projectId: entity.projectId,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String? ?? 'Medium',
      projectId: json['projectId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'projectId': projectId,
    };
  }
}
