class AppConstants {
  AppConstants._();

  // Collections
  static const String usersCollection = 'users';
  static const String postsCollection = 'posts';
  static const String commentsCollection = 'comments';
  static const String likesCollection = 'likes';

  // Limits
  static const int paginationLimit = 10;
  static const int maxPostTitleLength = 100;
  static const int maxPostContentLength = 2000;
  static const int maxCommentLength = 500;

  // Durations
  static const Duration splashDuration = Duration(seconds: 3);
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Design sizes
  static const double designWidth = 402;
  static const double designHeight = 874;
}
