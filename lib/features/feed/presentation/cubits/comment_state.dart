import 'package:connect_hub/features/post/data/models/comment_model.dart';
import 'package:equatable/equatable.dart';

enum CommentStatus { initial, loading, loaded, adding, success, error }

class CommentState extends Equatable {
  const CommentState({
    this.status = CommentStatus.initial,
    this.comments = const <CommentModel>[],
    this.errorMessage,
  });

  final CommentStatus status;
  final List<CommentModel> comments;
  final String? errorMessage;

  bool get isLoading => status == CommentStatus.loading;
  bool get isAdding => status == CommentStatus.adding;

  CommentState copyWith({
    CommentStatus? status,
    List<CommentModel>? comments,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, comments, errorMessage];
}
