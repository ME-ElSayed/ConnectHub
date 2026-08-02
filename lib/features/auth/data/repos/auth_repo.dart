import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/features/auth/data/repos/image_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final ImageRepository _imageRepository;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    required ImageRepository imageRepository,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _imageRepository = imageRepository;

  User? get currentUser => _auth.currentUser;

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required File image,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    final imageUrl = await _imageRepository.uploadImage(image);

    await user.updateDisplayName(name);
    await user.updatePhotoURL(imageUrl);

    await _firestore.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "name": name,
      "email": email,
      "photoUrl": imageUrl,
      "createdAt": FieldValue.serverTimestamp(),
    });

    await user.reload();

    return _auth.currentUser!;
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user!;
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}