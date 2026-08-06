import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  const CommentModel({
    this.id,
    required this.userId,
    this.username = '',
    this.profileImageUrl = '',
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String userId;
  final String username;
  final String profileImageUrl;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory CommentModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdAtValue = map['createdAt'];
    final updatedAtValue = map['updatedAt'];

    DateTime parseDateTime(Object? value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    return CommentModel(
      id: id,
      userId: map['userId'] as String? ?? '',
      username: map['username'] as String? ?? '',
      profileImageUrl:
          map['profileImageUrl'] as String? ??
          map['profileImage'] as String? ??
          '',
      message: map['message'] as String? ?? '',
      createdAt: parseDateTime(createdAtValue),
      updatedAt: parseDateTime(updatedAtValue ?? createdAtValue),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'message': message,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  CommentModel copyWith({
    String? id,
    String? userId,
    String? username,
    String? profileImageUrl,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    username,
    profileImageUrl,
    message,
    createdAt,
    updatedAt,
  ];
}
