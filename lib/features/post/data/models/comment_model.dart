import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';

class CommentModel {
  const CommentModel({
    this.id,
    required this.user,
    required this.message,
    required this.createdAt,
    this.commentCount = 0,
  });

  final String? id;
  final AppUser user;
  final String message;
  final DateTime createdAt;
  final int commentCount;

  factory CommentModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdAtValue = map['createdAt'];
    final userMap = map['user'] as Map<String, dynamic>? ?? const {};

    return CommentModel(
      id: id,
      user: AppUser.fromMap(userMap),
      message: map['message'] as String? ?? '',
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : createdAtValue is DateTime
          ? createdAtValue
          : DateTime.now(),
      commentCount: map['commentCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'message': message,
      'createdAt': Timestamp.fromDate(createdAt),
      'commentCount': commentCount,
    };
  }

  CommentModel copyWith({
    String? id,
    AppUser? user,
    String? message,
    DateTime? createdAt,
    int? commentCount,
  }) {
    return CommentModel(
      id: id ?? this.id,
      user: user ?? this.user,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      commentCount: commentCount ?? this.commentCount,
    );
  }
}
