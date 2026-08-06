import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  const PostModel({
    this.id,
    required this.ownerId,
    this.ownerUsername = '',
    this.ownerDisplayName = '',
    this.ownerProfileImageUrl = '',
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
  });

  final String? id;
  final String ownerId;
  final String ownerUsername;
  final String ownerDisplayName;
  final String ownerProfileImageUrl;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;

  factory PostModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdAtValue = map['createdAt'];
    final updatedAtValue = map['updatedAt'];

    DateTime parseDateTime(Object? value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    int parseInt(Object? value) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      return 0;
    }

    return PostModel(
      id: id,
      ownerId: map['ownerId'] as String? ?? '',
      ownerUsername: map['ownerUsername'] as String? ?? '',
      ownerDisplayName: map['ownerDisplayName'] as String? ?? '',
      ownerProfileImageUrl: map['ownerProfileImageUrl'] as String? ?? '',
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      createdAt: parseDateTime(createdAtValue),
      updatedAt: parseDateTime(updatedAtValue ?? createdAtValue),
      likesCount: parseInt(map['likesCount']),
      commentsCount: parseInt(map['commentsCount']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'ownerUsername': ownerUsername,
      'ownerDisplayName': ownerDisplayName,
      'ownerProfileImageUrl': ownerProfileImageUrl,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }

  PostModel copyWith({
    String? id,
    String? ownerId,
    String? ownerUsername,
    String? ownerDisplayName,
    String? ownerProfileImageUrl,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likesCount,
    int? commentsCount,
  }) {
    return PostModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      ownerUsername: ownerUsername ?? this.ownerUsername,
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      ownerProfileImageUrl: ownerProfileImageUrl ?? this.ownerProfileImageUrl,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    ownerId,
    ownerUsername,
    ownerDisplayName,
    ownerProfileImageUrl,
    title,
    content,
    imageUrl,
    createdAt,
    updatedAt,
    likesCount,
    commentsCount,
  ];
}
