import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pegasus_app/core/error/failures.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserEntity user);
  Future<UserEntity?> getLastUser();
  Future<void> clearUser();
}

const String CACHED_USER_KEY = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserEntity user) {
    final userJson = json.encode({
      'id': user.id,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoUrl,
      'role': user.role,
    });
    return sharedPreferences.setString(CACHED_USER_KEY, userJson);
  }

  @override
  Future<UserEntity?> getLastUser() {
    final jsonString = sharedPreferences.getString(CACHED_USER_KEY);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> userMap = json.decode(jsonString);
        return Future.value(UserEntity(
          id: userMap['id'],
          email: userMap['email'],
          displayName: userMap['displayName'],
          photoUrl: userMap['photoUrl'],
          role: userMap['role'] ?? 'user',
        ));
      } catch (e) {
        throw CacheFailure();
      }
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<void> clearUser() {
    return sharedPreferences.remove(CACHED_USER_KEY);
  }
}
