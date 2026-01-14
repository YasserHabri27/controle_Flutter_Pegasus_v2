import 'package:equatable/equatable.dart';

enum ProjectStatus { todo, inProgress, done }

class ProjectEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final ProjectStatus status;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final double progress;

  const ProjectEntity({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    this.startDate,
    this.endDate,
    this.progress = 0.0,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        createdAt,
        startDate,
        endDate,
        progress,
      ];

  ProjectEntity copyWith({
    String? id,
    String? title,
    String? description,
    ProjectStatus? status,
    DateTime? createdAt,
    DateTime? startDate,
    DateTime? endDate,
    double? progress,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      progress: progress ?? this.progress,
    );
  }
}
