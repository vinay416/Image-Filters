import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

mixin ImageService{
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  Future<(String? path, String? error)> openGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) throw Exception("Image Gallery picking error");
      final (imagePath, error) = await _cropImage(image);
      if (error != null) return (null, error);
      return (imagePath, null);
    } catch (e) {
      log("Error --> $e");
      return (null, e.toString());
    }
  }

  Future<(String? path, String? error)> openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) throw Exception("Image Camera pick error");
      final (imagePath, error) = await _cropImage(image);
      if (error != null) return (null, error);
      return (imagePath, null);
    } catch (e) {
      log("Error --> $e");
      return (null, e.toString());
    }
  }

  Future<(String? path, String? error)> _cropImage(
    XFile image,
  ) async {
    try {
      final croppedFile = await _cropper.cropImage(
        sourcePath: image.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );

      if (croppedFile == null) throw Exception("Cropped file null");

      final path = croppedFile.path;
      return (path, null);
    } catch (e) {
      log("Error ---> $e");
      return (null, e.toString());
    }
  }

}
