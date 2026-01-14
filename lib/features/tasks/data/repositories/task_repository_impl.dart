import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local/task_local_datasource.dart';
import '../datasources/remote/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final Connectivity connectivity;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  /// Vérifie l'état de la connexion internet.
  /// Nous utilisons cette méthode pour décider si nous devons appeler l'API distante
  /// ou basculer sur le stockage local.
  Future<bool> get _isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Récupère la liste des tâches.
  /// Stratégie : "Remote First, Local Fallback"
  /// 1. Si connecté : Nous tentons de récupérer les données depuis l'API.
  ///    En cas de succès, nous mettons à jour le cache local Hive.
  ///    En cas d'échec serveur, nous lisons le cache local.
  /// 2. Si non connecté : Nous retournons directement les données du cache local.
  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    if (await _isConnected) {
      try {
        final remoteTasks = await remoteDataSource.getTasks();
        final taskModels = remoteTasks.map((t) => TaskModel.fromEntity(t)).toList();
        await localDataSource.cacheTasks(taskModels);
        return Right(remoteTasks);
      } catch (e) {
         try {
          final localTasks = await localDataSource.getTasks();
          return Right(localTasks);
        } catch (e) {
          return Left(CacheFailure());
        }
      }
    } else {
      try {
        final localTasks = await localDataSource.getTasks();
        return Right(localTasks);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  /// Ajoute une nouvelle tâche.
  /// Stratégie : "Optimistic UI"
  /// 1. Nous sauvegardons immédiatement la tâche dans le stockage local Hive
  ///    pour que l'utilisateur voie le changement instantanément.
  /// 2. Si connecté, nous envoyons la tâche au serveur en arrière-plan.
  ///    Si l'envoi échoue, la donnée reste présente localement (à synchroniser plus tard).
  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    try {
      await localDataSource.addTask(taskModel);
    } catch (e) {
      return Left(CacheFailure());
    }

    if (await _isConnected) {
      try {
        await remoteDataSource.addTask(taskModel);
      } catch (e) {
      }
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    final taskModel = TaskModel.fromEntity(task);
    try {
      await localDataSource.updateTask(taskModel);
    } catch (e) {
      return Left(CacheFailure());
    }

    if (await _isConnected) {
      try {
        await remoteDataSource.updateTask(taskModel);
      } catch (e) {
      }
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await localDataSource.deleteTask(taskId);
    } catch (e) {
      return Left(CacheFailure());
    }

    if (await _isConnected) {
      try {
        await remoteDataSource.deleteTask(taskId);
      } catch (e) {
      }
    }
    return const Right(null);
  }
}
