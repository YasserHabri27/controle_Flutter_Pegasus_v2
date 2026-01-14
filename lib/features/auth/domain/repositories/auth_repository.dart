import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<bool> isAuthenticated();
}
