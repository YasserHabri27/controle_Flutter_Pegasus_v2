import '../../domain/entities/project_entity.dart';
import '../../data/models/project_model.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'project_api_service.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectEntity>> getProjects();
  Future<void> createProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String id);
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final ProjectApiService apiService;

  ProjectRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ProjectEntity>> getProjects() async {
    try {
      return await apiService.getProjects();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> createProject(ProjectModel project) async {
    try {
      await apiService.createProject(project);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    try {
      await apiService.updateProject(project.id, project);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    try {
      await apiService.deleteProject(id);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
