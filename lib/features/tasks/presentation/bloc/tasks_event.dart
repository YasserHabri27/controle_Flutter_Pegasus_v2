part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TasksEvent {}

class AddTaskEvent extends TasksEvent {
  final Map<String, dynamic> task;
  const AddTaskEvent(this.task);
  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TasksEvent {
  final Map<String, dynamic> task;
  const UpdateTaskEvent(this.task);
  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TasksEvent {
  final String taskId;
  const DeleteTaskEvent(this.taskId);
  @override
  List<Object> get props => [taskId];
}
