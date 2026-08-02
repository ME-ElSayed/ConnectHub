import 'dart:io';

import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
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

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
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

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const AuthLoading());

    try {
      await repository.resetPassword(email);

      emit(
        const AuthMessage(
          "Password reset email sent successfully.",
        ),
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await repository.logout();

    emit(const AuthInitial());
  }
}