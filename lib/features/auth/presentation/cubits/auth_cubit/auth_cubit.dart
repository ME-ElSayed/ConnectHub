import 'dart:io';

import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(const AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    emit(const AuthLoading());

    try {
      final user = await repository.register(
        name: name,
        email: email,
        password: password,
        image: image,
      );

      emit(RegisterSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: _authErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final user = await repository.login(
        email: email,
        password: password,
      );

      emit(LoginSuccess(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: _authErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    emit(const AuthLoading());

    try {
      await repository.resetPassword(email);

      emit(const ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: _authErrorMessage(e)));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());

    try {
      await repository.logout();

      emit(const LogoutSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  String _authErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return 'Wrong email or password';

      case 'weak-password':
        return 'The password provided is too weak';

      case 'email-already-in-use':
        return 'The account already exists for that email';

      case 'invalid-email':
        return 'Please enter a valid email address';

      case 'user-disabled':
        return 'This account has been disabled';

      case 'requires-recent-login':
        return 'Please sign in again to delete this account';

      default:
        return exception.message ??
            'Authentication failed. Please try again.';
    }
  }
}