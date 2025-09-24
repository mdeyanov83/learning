import 'package:firebase_auth/firebase_auth.dart' show User;

@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser(this.isEmailVerified);
}
