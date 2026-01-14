import 'package:firebase_auth/firebase_auth.dart';
import 'package:pegasus_app/core/error/failures.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String password);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToEntity(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Login failed');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToEntity(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure(e.message ?? 'Registration failed');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return _mapFirebaseUserToEntity(user);
    }
    return null;
  }

  UserEntity _mapFirebaseUserToEntity(User user) {
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      // For now, default role is user. Ideally, fetch role from Firestore.
      role: 'user', 
    );
  }
}
