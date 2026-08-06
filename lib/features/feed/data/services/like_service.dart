import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/post/data/models/like_model.dart';

class LikeService {
  LikeService({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;

  Stream<List<LikeModel>> watchLikes(String postId) {
    return _firestoreService.watchLikes(postId);
  }

  Future<bool> isLiked(String postId, String currentUserId) {
    return _firestoreService.isLiked(
      postId: postId,
      currentUserId: currentUserId,
    );
  }

  Future<void> likePost({required String postId, required LikeModel like}) {
    return _firestoreService.likePost(postId: postId, like: like);
  }

  Future<void> unlikePost({
    required String postId,
    required String currentUserId,
  }) {
    return _firestoreService.unlikePost(
      postId: postId,
      currentUserId: currentUserId,
    );
  }
}
