import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/core/constant/app_constants.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';
import 'package:connect_hub/features/chat/data/model/chat_message.dart';
import 'package:connect_hub/features/post/data/models/comment_model.dart';
import 'package:connect_hub/features/post/data/models/like_model.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';

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

  Future<void> addPost(PostModel post) async {
    final postsCollection = _postsCollection;
    final doc = post.id == null
        ? postsCollection.doc()
        : postsCollection.doc(post.id);
    await doc.set(post.copyWith(id: doc.id).toMap());
  }

  Stream<List<PostModel>> watchPosts() {
    return _postsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostModel.fromMap(doc.data(), id: doc.id))
              .toList(),
        );
  }

  Stream<List<PostModel>> watchUserPosts(String ownerId) {
    return _postsCollection
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostModel.fromMap(doc.data(), id: doc.id))
              .toList(),
        );
  }

  Stream<List<CommentModel>> watchComments(String postId) {
    return _commentsCollection(postId)
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CommentModel.fromMap(doc.data(), id: doc.id))
              .toList(),
        );
  }

  Future<String> addComment({
    required String postId,
    required CommentModel comment,
  }) async {
    final postRef = _postDocument(postId);
    final commentRef = _commentsCollection(postId).doc();
    final savedComment = comment.copyWith(id: commentRef.id);

    await _firestore.runTransaction((transaction) async {
      final postSnapshot = await transaction.get(postRef);
      if (!postSnapshot.exists) {
        throw StateError('Post not found.');
      }

      transaction.set(commentRef, savedComment.toMap());
      transaction.update(postRef, {
        'commentsCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(comment.updatedAt),
      });
    });

    return commentRef.id;
  }

  Stream<List<LikeModel>> watchLikes(String postId) {
    return _likesCollection(postId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => LikeModel.fromMap(doc.data(), id: doc.id))
              .toList(),
        );
  }

  Future<bool> isLiked({
    required String postId,
    required String currentUserId,
  }) async {
    final snapshot = await _likesCollection(postId).doc(currentUserId).get();
    return snapshot.exists;
  }

  Future<void> likePost({
    required String postId,
    required LikeModel like,
  }) async {
    final postRef = _postDocument(postId);
    final likeRef = _likesCollection(postId).doc(like.userId);
    final savedLike = like.copyWith(id: like.userId);

    await _firestore.runTransaction((transaction) async {
      final postSnapshot = await transaction.get(postRef);
      final likeSnapshot = await transaction.get(likeRef);

      if (!postSnapshot.exists) {
        throw StateError('Post not found.');
      }

      if (likeSnapshot.exists) {
        return;
      }

      transaction.set(likeRef, savedLike.toMap());
      transaction.update(postRef, {
        'likesCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(like.createdAt),
      });
    });
  }

  Future<void> unlikePost({
    required String postId,
    required String currentUserId,
  }) async {
    final postRef = _postDocument(postId);
    final likeRef = _likesCollection(postId).doc(currentUserId);
    final now = DateTime.now();

    await _firestore.runTransaction((transaction) async {
      final postSnapshot = await transaction.get(postRef);
      final likeSnapshot = await transaction.get(likeRef);

      if (!postSnapshot.exists) {
        throw StateError('Post not found.');
      }

      if (!likeSnapshot.exists) {
        return;
      }

      transaction.delete(likeRef);
      transaction.update(postRef, {
        'likesCount': FieldValue.increment(-1),
        'updatedAt': Timestamp.fromDate(now),
      });
    });
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

  CollectionReference<Map<String, dynamic>> get _postsCollection {
    return _firestore.collection(AppConstants.postsCollection);
  }

  DocumentReference<Map<String, dynamic>> _postDocument(String postId) {
    return _postsCollection.doc(postId);
  }

  CollectionReference<Map<String, dynamic>> _commentsCollection(String postId) {
    return _postDocument(postId).collection(AppConstants.commentsCollection);
  }

  CollectionReference<Map<String, dynamic>> _likesCollection(String postId) {
    return _postDocument(postId).collection(AppConstants.likesCollection);
  }
}
