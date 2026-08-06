import 'dart:io';

import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/auth/data/repos/image_repo.dart';
import 'package:connect_hub/features/post/data/models/post_model.dart';

class PostRepository {
  PostRepository({
    required FirestoreService firestoreService,
    required ImageRepository imageRepository,
  }) : _firestoreService = firestoreService,
       _imageRepository = imageRepository;

  final FirestoreService _firestoreService;
  final ImageRepository _imageRepository;

  Future<void> addPost({
    required String userId,
    required String title,
    required String content,
    File? image,
  }) async {
    final imageUrl = image != null && image.path.isNotEmpty
        ? await _imageRepository.uploadImage(image)
        : '';

    final post = PostModel(
      userId: userId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    await _firestoreService.addPost(post);
  }
}
