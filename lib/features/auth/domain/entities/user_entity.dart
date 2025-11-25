import 'package:equatable/equatable.dart';

/// User entity - represents the business logic model
class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;
  final bool emailVerified;
  final String? photoUrl;

  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    required this.emailVerified,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [uid, email, displayName, emailVerified, photoUrl];
}
