import 'package:hive/hive.dart';
import '../../domain/entities/task_entity.dart';
import '../../data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> cacheTasks(List<TaskModel> tasks);
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final String _boxName = 'tasksBox';

  Future<Box<TaskModel>> get _box async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<TaskModel>(_boxName);
    }
    return await Hive.openBox<TaskModel>(_boxName);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> cacheTasks(List<TaskModel> tasks) async {
    final box = await _box;
    await box.clear();
    for (var task in tasks) {
      await box.put(task.id, task);
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    final box = await _box;
    await box.put(task.id, task);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    final box = await _box;
    await box.put(task.id, task); // Hive overwrites if key exists
  }

  @override
  Future<void> deleteTask(String id) async {
    final box = await _box;
    await box.delete(id);
  }
}
