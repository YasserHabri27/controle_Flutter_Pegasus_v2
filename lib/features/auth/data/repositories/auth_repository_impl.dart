import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      await localDataSource.cacheUser(user);
      return Right(user);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password) async {
    try {
      final user = await remoteDataSource.register(email, password);
      await localDataSource.cacheUser(user);
      return Right(user);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      // First try to get from local cache for speed/offline
      final localUser = await localDataSource.getLastUser();
      if (localUser != null) {
        // Optionally verify with remote if needed, for now return local
        // Ideally we check if token is valid, etc.
        return Right(localUser);
      }

      // If not in cache, check remote (e.g. if auto-login via firebase current user)
      final remoteUser = await remoteDataSource.getCurrentUser();
      if (remoteUser != null) {
        await localDataSource.cacheUser(remoteUser);
        return Right(remoteUser);
      }

      return const Left(AuthFailure('No user logged in'));
    } catch (e) {
      return Left(CacheFailure());
    }
  }
  
  @override
  Future<bool> isAuthenticated() async {
    final result = await getCurrentUser();
    return result.isRight();
  }
}
