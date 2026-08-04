import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<void> setUserData(AppUser user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<AppUser?> getUser(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return AppUser.fromMap(snapshot.data()!);
  }
}
