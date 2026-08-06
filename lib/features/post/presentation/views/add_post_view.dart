import 'dart:io';

import 'package:connect_hub/features/post/presentation/views/widgets/add_post_form.dart';
import 'package:flutter/material.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key, this.onPosted});

  final VoidCallback? onPosted;

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  File? selectedImage;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void onImageChanged(File? image) {
    setState(() {
      selectedImage = image;
    });
  }

  void clearImage() {
    setState(() {
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddPostForm(
        formKey: formKey,
        titleController: titleController,
        contentController: contentController,
        selectedImage: selectedImage,
        onImageChanged: onImageChanged,
        onClearImage: clearImage,
        onPosted: widget.onPosted,
      ),
    );
  }
}