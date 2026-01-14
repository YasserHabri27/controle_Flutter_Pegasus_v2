import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dueDate;
  final String priority;
  final String projectId;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueDate,
    required this.priority,
    required this.projectId,
  });

  @override
  List<Object?> get props => [id, title, description, isCompleted, dueDate, priority, projectId];
}
