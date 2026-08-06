import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/features/post/data/models/comment_model.dart';
import 'package:connect_hub/features/post/data/models/like_model.dart';

class PostModel {
  const PostModel({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    this.likes = const [],
    this.comments = const [],
  });

  final String? id;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final List<LikeModel> likes;
  final List<CommentModel> comments;

  factory PostModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdAtValue = map['createdAt'];
    final likesData = map['likes'] as List<dynamic>? ?? const [];
    final commentsData = map['comments'] as List<dynamic>? ?? const [];

    return PostModel(
      id: id,
      userId: map['userId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : createdAtValue is DateTime
          ? createdAtValue
          : DateTime.now(),
      likes: likesData
          .map((likeMap) => LikeModel.fromMap(likeMap as Map<String, dynamic>))
          .toList(),
      comments: commentsData
          .map(
            (commentMap) =>
                CommentModel.fromMap(commentMap as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'likes': likes.map((like) => like.toMap()).toList(),
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }

  PostModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    int? likeCount,
    int? commentCount,
    List<LikeModel>? likes,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
