import 'package:hive/hive.dart';
import '../../domain/entities/project_entity.dart';

part 'project_model.g.dart';

@HiveType(typeId: 1)
class ProjectModel extends ProjectEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String statusString;
  @HiveField(4)
  final DateTime createdAt;
  @HiveField(5)
  final DateTime? startDate;
  @HiveField(6)
  final DateTime? endDate;
  @HiveField(7)
  final double progress;

  const ProjectModel({
    required this.id,
    required this.title,
    this.description,
    required this.statusString,
    required this.createdAt,
    this.startDate,
    this.endDate,
    this.progress = 0.0,
  }) : super(
          id: id,
          title: title,
          description: description,
          status: ProjectStatus.values.firstWhere(
            (e) => e.name == statusString,
            orElse: () => ProjectStatus.todo,
          ),
          createdAt: createdAt,
          startDate: startDate,
          endDate: endDate,
          progress: progress,
        );

  factory ProjectModel.fromEntity(ProjectEntity entity) {
    return ProjectModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      statusString: entity.status.name,
      createdAt: entity.createdAt,
      startDate: entity.startDate,
      endDate: entity.endDate,
      progress: entity.progress,
    );
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      statusString: json['status'] as String? ?? 'todo',
      createdAt: DateTime.parse(json['createdAt'] as String),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': statusString,
      'createdAt': createdAt.toIso8601String(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'progress': progress,
    };
  }
}
