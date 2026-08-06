import 'package:connect_hub/features/auth/data/models/user_model.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, loaded, logoutSuccess, failure }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.posts = const <PostModel>[],
    this.errorMessage,
    this.isLoggingOut = false,
  });

  final ProfileStatus status;
  final AppUser? user;
  final List<PostModel> posts;
  final String? errorMessage;
  final bool isLoggingOut;

  bool get hasPosts => posts.isNotEmpty;
  bool get isLoading => status == ProfileStatus.loading;

  ProfileState copyWith({
    ProfileStatus? status,
    AppUser? user,
    List<PostModel>? posts,
    String? errorMessage,
    bool? isLoggingOut,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
    );
  }

  @override
  List<Object?> get props => [status, user, posts, errorMessage, isLoggingOut];
}
