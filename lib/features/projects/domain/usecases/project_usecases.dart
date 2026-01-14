import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'package:pegasus_app/core/usecases/usecase.dart';
import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

class GetProjects implements UseCase<List<ProjectEntity>, NoParams> {
  final ProjectRepository repository;
  GetProjects(this.repository);

  @override
  Future<Either<Failure, List<ProjectEntity>>> call(NoParams params) async {
    return await repository.getProjects();
  }
}

class CreateProject implements UseCase<void, ProjectEntity> {
  final ProjectRepository repository;
  CreateProject(this.repository);

  @override
  Future<Either<Failure, void>> call(ProjectEntity params) async {
    return await repository.createProject(params);
  }
}

class UpdateProject implements UseCase<void, ProjectEntity> {
  final ProjectRepository repository;
  UpdateProject(this.repository);

  @override
  Future<Either<Failure, void>> call(ProjectEntity params) async {
    return await repository.updateProject(params);
  }
}

class DeleteProject implements UseCase<void, String> {
  final ProjectRepository repository;
  DeleteProject(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteProject(params);
  }
}
