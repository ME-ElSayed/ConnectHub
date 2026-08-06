import 'package:equatable/equatable.dart';

enum LikeStatus { initial, loading, liked, unliked, loaded, error }

class LikeState extends Equatable {
  const LikeState({
    this.status = LikeStatus.initial,
    this.isLiked = false,
    this.likesCount = 0,
    this.errorMessage,
  });

  final LikeStatus status;
  final bool isLiked;
  final int likesCount;
  final String? errorMessage;

  LikeState copyWith({
    LikeStatus? status,
    bool? isLiked,
    int? likesCount,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return LikeState(
      status: status ?? this.status,
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, isLiked, likesCount, errorMessage];
}
