import 'package:hive/hive.dart';
import '../../data/models/project_model.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<void> cacheProjects(List<ProjectModel> projects);
  Future<void> createProject(ProjectModel project);
  Future<void> updateProject(ProjectModel project);
  Future<void> deleteProject(String id);
}

class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  final String _boxName = 'projectsBox';

  Future<Box<ProjectModel>> get _box async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<ProjectModel>(_boxName);
    }
    return await Hive.openBox<ProjectModel>(_boxName);
  }

  @override
  Future<List<ProjectModel>> getProjects() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<void> cacheProjects(List<ProjectModel> projects) async {
    final box = await _box;
    await box.clear();
    for (var project in projects) {
      await box.put(project.id, project);
    }
  }

  @override
  Future<void> createProject(ProjectModel project) async {
    final box = await _box;
    await box.put(project.id, project);
  }

  @override
  Future<void> updateProject(ProjectModel project) async {
    final box = await _box;
    await box.put(project.id, project);
  }

  @override
  Future<void> deleteProject(String id) async {
    final box = await _box;
    await box.delete(id);
  }
}
