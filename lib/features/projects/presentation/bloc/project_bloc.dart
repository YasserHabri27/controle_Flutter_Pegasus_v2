import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'package:pegasus_app/core/usecases/usecase.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/project_usecases.dart';
import 'project_event.dart';
import 'project_state.dart';

/// ProjectBloc : Gestionnaire d'état pour les projets.
class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetProjects getProjects;
  final CreateProject createProject;
  final UpdateProject updateProject;

  ProjectBloc({
    required this.getProjects,
    required this.createProject,
    required this.updateProject,
  }) : super(ProjectsInitial()) {
    on<LoadProjects>(_onLoadProjects);
    on<CreateProjectEvent>(_onCreateProject);
    on<UpdateProjectStatusEvent>(_onUpdateProjectStatus);
  }

  Future<void> _onLoadProjects(LoadProjects event, Emitter<ProjectState> emit) async {
    emit(ProjectsLoading());
    final result = await getProjects(NoParams());
    result.fold(
      (failure) => emit(ProjectsError(message: failure.message)),
      (projects) => emit(ProjectsLoaded(projects: projects)),
    );
  }

  Future<void> _onCreateProject(CreateProjectEvent event, Emitter<ProjectState> emit) async {
    try {
      final newProject = ProjectEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        description: event.description,
        status: ProjectStatus.todo,
        createdAt: DateTime.now(),
        startDate: event.startDate,
        endDate: event.endDate,
        progress: 0.0,
      );
      final result = await createProject(newProject);
      result.fold(
        (failure) => emit(ProjectsError(message: failure.message)),
        (_) => add(LoadProjects()),
      );
    } catch (e) {
      emit(ProjectsError(message: e.toString()));
    }
  }

  Future<void> _onUpdateProjectStatus(UpdateProjectStatusEvent event, Emitter<ProjectState> emit) async {
    final currentState = state;
    if (currentState is ProjectsLoaded) {
      try {
        final projectToUpdate = currentState.projects.firstWhere((p) => p.id == event.projectId);
        final updatedProject = projectToUpdate.copyWith(status: event.status);
        
        final result = await updateProject(updatedProject);
        result.fold(
          (failure) => emit(ProjectsError(message: failure.message)),
          (_) => add(LoadProjects()),
        );
      } catch (e) {
        emit(ProjectsError(message: e.toString()));
      }
    }
  }
}
