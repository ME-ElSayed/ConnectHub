import 'package:connect_hub/features/auth/data/models/user_model.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoginSuccess extends AuthState {
  final AppUser user;

  const LoginSuccess({required this.user});
}

class RegisterSuccess extends AuthState {
  final AppUser user;

  const RegisterSuccess({required this.user});
}

class ResetPasswordSuccess extends AuthState {
  const ResetPasswordSuccess();
}

class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}