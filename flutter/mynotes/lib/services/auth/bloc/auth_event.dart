import 'package:flutter/foundation.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogin(
    this.email,
    this.password,
  );
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegsiter(this.email, this.password);
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}

