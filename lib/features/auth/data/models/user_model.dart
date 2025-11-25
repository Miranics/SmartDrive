import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartdrive/features/auth/domain/entities/user_entity.dart';

/// User Model - extends entity and adds JSON serialization
class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    super.displayName,
    required super.emailVerified,
    super.photoUrl,
  });

  /// Convert Firebase User to UserModel
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      emailVerified: user.emailVerified,
      photoUrl: user.photoURL,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'emailVerified': emailVerified,
      'photoUrl': photoUrl,
    };
  }

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      emailVerified: json['emailVerified'] as bool,
      photoUrl: json['photoUrl'] as String?,
    );
  }
}
