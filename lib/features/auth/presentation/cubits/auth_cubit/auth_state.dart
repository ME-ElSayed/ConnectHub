import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}

class AuthMessage extends AuthState {
  final String message;

  const AuthMessage(this.message);
}