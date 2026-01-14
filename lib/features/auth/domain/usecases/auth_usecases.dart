import 'package:dartz/dartz.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'package:pegasus_app/core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

class RegisterUser implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});
}

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUser(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}

class CheckAuthStatus implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
