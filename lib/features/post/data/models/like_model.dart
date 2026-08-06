import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_hub/features/auth/data/models/user_model.dart';

class LikeModel {
  const LikeModel({
    this.id,
    required this.user,
    required this.createdAt,
    this.likeCount = 0,
  });

  final String? id;
  final AppUser user;
  final DateTime createdAt;
  final int likeCount;

  factory LikeModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdAtValue = map['createdAt'];
    final userMap = map['user'] as Map<String, dynamic>? ?? const {};

    return LikeModel(
      id: id,
      user: AppUser.fromMap(userMap),
      createdAt: createdAtValue is Timestamp
          ? createdAtValue.toDate()
          : createdAtValue is DateTime
          ? createdAtValue
          : DateTime.now(),
      likeCount: map['likeCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'createdAt': Timestamp.fromDate(createdAt),
      'likeCount': likeCount,
    };
  }

  LikeModel copyWith({
    String? id,
    AppUser? user,
    DateTime? createdAt,
    int? likeCount,
  }) {
    return LikeModel(
      id: id ?? this.id,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}
