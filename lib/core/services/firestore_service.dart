import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';
import 'package:connect_hub/features/chat/data/model/chat_message.dart';

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

  Future<void> saveChatMessage(
    String uid,
    String sessionId,
    ChatMessage message,
  ) async {
    final messages = _chatMessages(uid, sessionId);
    final doc = message.id == null ? messages.doc() : messages.doc(message.id);

    await doc.set(message.copyWith(id: doc.id).toMap());
  }

  Future<List<ChatMessage>> fetchChatHistory(
    String uid,
    String sessionId, {
    int limit = 50,
  }) async {
    final snapshot = await _chatMessages(
      uid,
      sessionId,
    ).orderBy('createdAt', descending: true).limit(limit).get();

    return snapshot.docs.reversed
        .map((doc) => ChatMessage.fromMap(doc.data(), id: doc.id))
        .toList();
  }

  Stream<List<ChatMessage>> watchChatMessages(String uid, String sessionId) {
    return _chatMessages(uid, sessionId)
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatMessage.fromMap(doc.data(), id: doc.id))
              .toList(),
        );
  }

  CollectionReference<Map<String, dynamic>> _chatMessages(
    String uid,
    String sessionId,
  ) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(sessionId)
        .collection('messages');
  }
}
