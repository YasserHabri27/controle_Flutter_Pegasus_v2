import '../../domain/entities/task_entity.dart';
import '../../data/models/task_model.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'task_api_service.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskEntity>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final TaskApiService apiService;

  TaskRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TaskEntity>> getTasks() async {
    try {
      return await apiService.getTasks();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await apiService.createTask(task);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await apiService.updateTask(task.id, task);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await apiService.deleteTask(id);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
