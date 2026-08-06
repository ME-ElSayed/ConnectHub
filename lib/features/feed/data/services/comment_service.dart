import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/post/data/models/comment_model.dart';

class CommentService {
  CommentService({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  Stream<List<CommentModel>> watchComments(String postId) {
    return _firestoreService.watchComments(postId);
  }

  Future<String> addComment({
    required String postId,
    required CommentModel comment,
  }) {
    return _firestoreService.addComment(postId: postId, comment: comment);
  }
}
