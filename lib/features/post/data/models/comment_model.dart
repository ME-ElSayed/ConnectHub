import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  const CommentModel({
    this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    this.username,
    this.profileImage,
  });

  final String? id;
  final String userId;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? username;
  final String? profileImage;

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
      message: map['message'] as String? ?? '',
      createdAt: parseDateTime(createdAtValue),
      updatedAt: parseDateTime(updatedAtValue ?? createdAtValue),
      username: map['username'] as String?,
      profileImage: map['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'userId': userId,
      'message': message,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };

    if (username != null) {
      data['username'] = username;
    }

    if (profileImage != null) {
      data['profileImage'] = profileImage;
    }

    return data;
  }

  CommentModel copyWith({
    String? id,
    String? userId,
    String? message,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    String? profileImage,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    message,
    createdAt,
    updatedAt,
    username,
    profileImage,
  ];
}
