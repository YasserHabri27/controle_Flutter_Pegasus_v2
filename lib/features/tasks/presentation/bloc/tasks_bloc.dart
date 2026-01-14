import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'package:pegasus_app/core/usecases/usecase.dart';
import '../../domain/usecases/task_usecases.dart';
import '../../domain/entities/task_entity.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

/// TasksBloc : Gestionnaire d'état pour les tâches.
///
/// Ce BLoC centralise toute la logique métier liée aux tâches.
/// Il interagit avec les UseCases (Clean Architecture) pour :
/// - Charger la liste des tâches (LoadTasks)
/// - Ajouter, Modifier et Supprimer des tâches
///
/// Nous utilisons le pattern BLoC pour garantir une séparation claire entre l'interface
/// utilisateur (Presentation) et la logique métier (Domain).
class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TasksBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TasksInitial()) {
    // Enregistrement des Handlers d'événements
    on<LoadTasks>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  /// Charge les tâches depuis le UseCase GetTasks.
  /// En cas de succès, nous émettons [TasksLoaded] avec la liste des tâches.
  /// En cas d'échec (ex: erreur de cache ou serveur), nous émettons [TasksError].
  Future<void> _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    final result = await getTasks(NoParams());
    result.fold(
      (failure) => emit(const TasksError(message: "Erreur lors du chargement des tâches")),
      (tasks) {
        // Conversion des Entités du Domaine en Maps pour l'UI (Architecture simplifiée pour l'UI)
        // Dans une version future, l'UI devrait consommer directement les Entités.
        final tasksMap = tasks.map((t) => {
          'id': t.id,
          'title': t.title,
          'description': t.description,
          'isCompleted': t.isCompleted,
          'dueDate': t.dueDate.toIso8601String(),
          'priority': t.priority,
          'projectId': t.projectId,
        }).toList();
        
        emit(TasksLoaded(tasks: tasksMap));
      },
    );
  }

  Future<void> _onAddTask(
    AddTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    // We assume event.task is a Map as per previous implementation
    // We need to convert Map to Entity
    final taskMap = event.task; 
    final taskEntity = TaskEntity(
        id: taskMap['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(), // Generate ID if missing
        title: taskMap['title'],
        description: taskMap['description'] ?? '',
        isCompleted: taskMap['isCompleted'] ?? false,
        dueDate: taskMap['dueDate'] ?? DateTime.now(),
        priority: taskMap['priority'] ?? 'Medium',
        projectId: taskMap['projectId'],
    );

    final result = await addTask(taskEntity);
    result.fold(
      (failure) => emit(TasksError(message: _mapFailureToMessage(failure))),
      (_) => add(LoadTasks()),
    );
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    final taskMap = event.task;
    final taskEntity = TaskEntity(
        id: taskMap['id'],
        title: taskMap['title'],
        description: taskMap['description'] ?? '',
        isCompleted: taskMap['isCompleted'] ?? false,
        dueDate: taskMap['dueDate'] ?? DateTime.now(),
        priority: taskMap['priority'] ?? 'Medium',
        projectId: taskMap['projectId'],
    );

    final result = await updateTask(taskEntity);
    result.fold(
      (failure) => emit(TasksError(message: _mapFailureToMessage(failure))),
      (_) => add(LoadTasks()),
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TasksState> emit,
  ) async {
    final result = await deleteTask(event.taskId);
    result.fold(
      (failure) => emit(TasksError(message: _mapFailureToMessage(failure))),
      (_) => add(LoadTasks()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Erreur serveur: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Erreur cache: ${failure.message}';
    }
    return 'Une erreur inattendue est survenue';
  }
}
