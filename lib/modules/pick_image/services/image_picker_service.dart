import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_filters/modules/pick_image/model/image_pick_model.dart';
import 'package:image_picker/image_picker.dart';

mixin ImagePickerService {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _cropper = ImageCropper();

  Future<(ImagePickModel? image, String? error)> openGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) throw Exception("Image Gallery picking error");
      final (imagePath, error) = await _cropImage(image);
      if (imagePath == null) return (null, error);
      final imageData = _imageDetails(image, imagePath);
      return (imageData, null);
    } catch (e) {
      log("Error --> $e");
      return (null, e.toString());
    }
  }

  Future<(ImagePickModel? image, String? error)> openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) throw Exception("Image Camera pick error");
      final (imagePath, error) = await _cropImage(image);
      if (imagePath == null) return (null, error);
      final imageData = _imageDetails(image, imagePath);
      return (imageData, null);
    } catch (e) {
      log("Error --> $e");
      return (null, e.toString());
    }
  }

  ImagePickModel _imageDetails(
    XFile image,
    String croppedPath,
  ) {
    final fileName = image.name.substring(0, image.name.lastIndexOf('.'));
    final mimetype = image.name.split('.').last;
    return ImagePickModel(
      path: croppedPath,
      name: fileName,
      mime: mimetype,
    );
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
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.blue,
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
