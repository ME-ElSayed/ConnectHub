import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  AuthRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

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

    final imageRef = _storage.ref("profile_images/${user.uid}.jpg");

    await imageRef.putFile(image);

    final photoUrl = await imageRef.getDownloadURL();

    await user.updateDisplayName(name);
    await user.updatePhotoURL(photoUrl);

    await _firestore.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
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