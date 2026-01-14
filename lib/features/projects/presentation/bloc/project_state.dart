import 'package:equatable/equatable.dart';
import '../../domain/entities/project_entity.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class ProjectsInitial extends ProjectState {}

class ProjectsLoading extends ProjectState {}

class ProjectsLoaded extends ProjectState {
  final List<ProjectEntity> projects;

  const ProjectsLoaded({required this.projects});

  @override
  List<Object> get props => [projects];
}

class ProjectsError extends ProjectState {
  final String message;

  const ProjectsError({required this.message});

  @override
  List<Object> get props => [message];
}
