import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'package:pegasus_app/core/usecases/usecase.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasks implements UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository repository;
  GetTasks(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await repository.getTasks();
  }
}

class AddTask implements UseCase<void, TaskEntity> {
  final TaskRepository repository;
  AddTask(this.repository);

  @override
  Future<Either<Failure, void>> call(TaskEntity params) async {
    return await repository.addTask(params);
  }
}

class UpdateTask implements UseCase<void, TaskEntity> {
  final TaskRepository repository;
  UpdateTask(this.repository);

  @override
  Future<Either<Failure, void>> call(TaskEntity params) async {
    return await repository.updateTask(params);
  }
}

class DeleteTask implements UseCase<void, String> {
  final TaskRepository repository;
  DeleteTask(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteTask(params);
  }
}
