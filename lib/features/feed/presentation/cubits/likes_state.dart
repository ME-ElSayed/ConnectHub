import 'package:connect_hub/features/post/data/models/like_model.dart';
import 'package:equatable/equatable.dart';

enum LikesStatus { initial, loading, loaded, error }

class LikesState extends Equatable {
  const LikesState({
    this.status = LikesStatus.initial,
    this.likes = const <LikeModel>[],
    this.errorMessage,
  });

  final LikesStatus status;
  final List<LikeModel> likes;
  final String? errorMessage;

  LikesState copyWith({
    LikesStatus? status,
    List<LikeModel>? likes,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return LikesState(
      status: status ?? this.status,
      likes: likes ?? this.likes,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, likes, errorMessage];
}
