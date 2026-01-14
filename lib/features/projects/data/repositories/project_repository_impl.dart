import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/local/project_local_datasource.dart';
import '../datasources/remote/project_remote_datasource.dart';
import '../models/project_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final ProjectLocalDataSource localDataSource;
  final Connectivity connectivity;

  ProjectRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  /// Vérifie la connectivité réseau pour déterminer la source de données à utiliser.
  Future<bool> get _isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Récupère les projets disponibles.
  /// Nous privilégions toujours la fraîcheur des données (API) si possible,
  /// mais nous garantissons l'accès hors-ligne grâce à Hive.
  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    if (await _isConnected) {
      try {
        final remoteProjects = await remoteDataSource.getProjects();
        final projectModels = remoteProjects.map((p) => ProjectModel.fromEntity(p)).toList();
        await localDataSource.cacheProjects(projectModels);
        return Right(remoteProjects);
      } catch (e) {
        try {
          final localProjects = await localDataSource.getProjects();
          return Right(localProjects);
        } catch (e) {
          return Left(CacheFailure());
        }
      }
    } else {
      try {
        final localProjects = await localDataSource.getProjects();
        return Right(localProjects);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  /// Crée un nouveau projet.
  /// Nous appliquons ici aussi une mise à jour optimiste (locale d'abord)
  /// pour une expérience utilisateur fluide et sans latence.
  @override
  Future<Either<Failure, void>> createProject(ProjectEntity project) async {
    final projectModel = ProjectModel.fromEntity(project);
    try {
      await localDataSource.createProject(projectModel);
    } catch (e) {
      return Left(CacheFailure());
    }
    
    if (await _isConnected) {
      try {
        await remoteDataSource.createProject(projectModel);
      } catch (e) {
      }
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateProject(ProjectEntity project) async {
    final projectModel = ProjectModel.fromEntity(project);
    try {
      await localDataSource.updateProject(projectModel);
    } catch (e) {
      return Left(CacheFailure());
    }

    if (await _isConnected) {
      try {
        await remoteDataSource.updateProject(projectModel);
      } catch (e) {
      }
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteProject(String id) async {
    try {
      await localDataSource.deleteProject(id);
    } catch (e) {
      return Left(CacheFailure());
    }

    if (await _isConnected) {
      try {
        await remoteDataSource.deleteProject(id);
      } catch (e) {
      }
    }
    return const Right(null);
  }
}
