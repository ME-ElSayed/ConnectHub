import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/services/firestore_service.dart';

class CurrentUserProfile {
  const CurrentUserProfile({
    required this.userId,
    required this.username,
    required this.profileImageUrl,
  });

  final String userId;
  final String username;
  final String profileImageUrl;

  static Future<CurrentUserProfile> resolve({
    required AuthService authService,
    required FirestoreService firestoreService,
  }) async {
    final firebaseUser = authService.currentUser;

    if (firebaseUser == null) {
      throw StateError('Please sign in to continue.');
    }

    final storedUser = await firestoreService
        .getUser(firebaseUser.uid)
        .catchError((_) => null);

    final storedName = storedUser?.name.trim() ?? '';
    final storedEmail = storedUser?.email.trim() ?? '';
    final storedPhotoUrl = storedUser?.photoUrl.trim() ?? '';
    final firebaseName = firebaseUser.displayName?.trim() ?? '';
    final firebaseEmail = firebaseUser.email?.trim() ?? '';
    final firebasePhotoUrl = firebaseUser.photoURL?.trim() ?? '';
    final email = storedEmail.isNotEmpty ? storedEmail : firebaseEmail;

    return CurrentUserProfile(
      userId: firebaseUser.uid,
      username: _resolveUsername(
        storedName: storedName,
        firebaseName: firebaseName,
        email: email,
      ),
      profileImageUrl: storedPhotoUrl.isNotEmpty
          ? storedPhotoUrl
          : firebasePhotoUrl,
    );
  }

  static String _resolveUsername({
    required String storedName,
    required String firebaseName,
    required String email,
  }) {
    if (storedName.isNotEmpty) return storedName;
    if (firebaseName.isNotEmpty) return firebaseName;
    if (email.contains('@')) return email.split('@').first;
    if (email.isNotEmpty) return email;
    return 'User';
  }
}
