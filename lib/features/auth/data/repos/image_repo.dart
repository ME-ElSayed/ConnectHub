import 'dart:io';

import 'package:dio/dio.dart';

class ImageRepository {
  final Dio dio;

  ImageRepository(this.dio);

  static const String _apiKey = "d8f4c73dc8e90780aa89cdcca630ede5";

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
