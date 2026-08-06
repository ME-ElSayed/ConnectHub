import 'package:connect_hub/features/post/data/models/post_model.dart';

final skeletonPosts = List.generate(
  5,
  (_) => PostModel(
    id: '',
    ownerId: '',
    ownerDisplayName: 'Loading User',
    ownerUsername: '@loading',
    ownerProfileImageUrl: '',
    title: 'Loading title',
    content:
        'Loading content Loading content Loading content',
    imageUrl: '',
    likesCount: 0,
    commentsCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
);