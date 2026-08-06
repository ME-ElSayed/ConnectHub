import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LikeModel extends Equatable {
  const LikeModel({this.id, required this.userId, required this.createdAt});

  final String? id;
  final String userId;
  final DateTime createdAt;

  factory LikeModel.fromMap(Map<String, dynamic> map, {String? id}) {
    final createdAtValue = map['createdAt'];

    DateTime parseDateTime(Object? value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    return LikeModel(
      id: id,
      userId: map['userId'] as String? ?? '',
      createdAt: parseDateTime(createdAtValue),
    );
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'createdAt': Timestamp.fromDate(createdAt)};
  }

  LikeModel copyWith({String? id, String? userId, DateTime? createdAt}) {
    return LikeModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, createdAt];
}
