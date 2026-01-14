import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String role; // 'admin', 'user'

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.role = 'user',
  });

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, role];
}
