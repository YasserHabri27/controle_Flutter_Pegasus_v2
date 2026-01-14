import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pegasus_app/core/error/failures.dart';
import 'package:pegasus_app/core/usecases/usecase.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;
  final CheckAuthStatus checkAuthStatus;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
    required this.checkAuthStatus,
  }) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onCheckRequested);
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await checkAuthStatus(NoParams());
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) => emit(Authenticated(user: user)), // Need to update AuthState to hold user
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await loginUser(LoginParams(
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await registerUser(RegisterParams(
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logoutUser(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (_) => emit(Unauthenticated()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map failure to user-friendly message
    return "Une erreur est survenue. Veuillez réessayer.";
  }
}
