import 'dart:io';

import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';
import 'package:connect_hub/features/auth/data/repos/image_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({
    required AuthService authService,
    required FirestoreService firestoreService,
    required ImageRepository imageRepository,
  }) : _authService = authService,
       _firestoreService = firestoreService,
       _imageRepository = imageRepository;

  final AuthService _authService;
  final FirestoreService _firestoreService;
  final ImageRepository _imageRepository;

  User? get currentUser => _authService.currentUser;

  AppUser? get currentAppUser {
    final user = _authService.currentUser;
    if (user == null) return null;

    return AppUser.fromFirebaseUser(user);
  }

  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    final credential = await _authService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;
    final imageUrl = await _imageRepository.uploadImage(image);

    await user.updateDisplayName(name);
    await user.updatePhotoURL(imageUrl);

    final appUser = AppUser(
      uid: user.uid,
      name: name,
      email: email,
      photoUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    await _firestoreService.setUserData(appUser);
    await user.reload();

    return AppUser.fromFirebaseUser(_authService.currentUser!);
  }

  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return AppUser.fromFirebaseUser(credential.user!);
  }

  Future<AppUser?> getUserData(String uid) async {
    return _firestoreService.getUser(uid);
  }

  Future<void> resetPassword(String email) async {
    await _authService.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _authService.signOut();
  }
}
