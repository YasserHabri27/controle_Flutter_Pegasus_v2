import 'package:equatable/equatable.dart';
import '../../domain/entities/project_entity.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class LoadProjects extends ProjectEvent {}

class CreateProjectEvent extends ProjectEvent {
  final String title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;

  const CreateProjectEvent({
    required this.title,
    this.description,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [title, description, startDate, endDate];
}

class UpdateProjectStatusEvent extends ProjectEvent {
  final String projectId;
  final ProjectStatus status;

  const UpdateProjectStatusEvent({required this.projectId, required this.status});

  @override
  List<Object> get props => [projectId, status];
}
