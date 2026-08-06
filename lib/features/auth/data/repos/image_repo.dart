import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageRepository {
  final Dio dio;

  ImageRepository(this.dio);

  String get _apiKey => dotenv.env['IMGBB_API_KEY']?.trim() ?? '';

  Future<String> uploadImage(File image) async {
    final formData = FormData.fromMap({
      "key": _apiKey,
      "image": await MultipartFile.fromFile(image.path),
    });

    final response = await dio.post(
      "https://api.imgbb.com/1/upload",
      data: formData,
    );

    if (response.statusCode == 200 && response.data["success"] == true) {
      return response.data["data"]["url"];
    }

    throw Exception("Failed to upload image");
  }
}
