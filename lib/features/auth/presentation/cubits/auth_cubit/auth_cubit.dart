import 'dart:io';

import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    emit(AuthLoading());

    try {
      final user = await repository.register(
        name: name,
        email: email,
        password: password,
        image: image,
      );

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Authentication failed"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await repository.login(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Authentication failed"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());

    try {
      await repository.resetPassword(email);

      emit(
        const AuthMessage(
          "Password reset email has been sent.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Failed to send email"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await repository.logout();
    emit(AuthInitial());
  }
}