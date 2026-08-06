import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';
import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';

class ProfileRepository {
  ProfileRepository({
    required AuthRepository authRepository,
    required FirestoreService firestoreService,
  }) : _authRepository = authRepository,
       _firestoreService = firestoreService;

  final AuthRepository _authRepository;
  final FirestoreService _firestoreService;

  AppUser? get currentUser => _authRepository.currentAppUser;

  Future<AppUser?> getCurrentUserDetails() async {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) return null;
    return _firestoreService.getUser(uid);
  }

  Stream<List<PostModel>> watchCurrentUserPosts() {
    final uid = _authRepository.currentUser?.uid;
    if (uid == null) {
      return Stream.value(const <PostModel>[]);
    }

    return _firestoreService.watchUserPosts(uid);
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
