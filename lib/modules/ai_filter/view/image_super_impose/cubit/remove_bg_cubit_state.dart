import 'dart:typed_data';

class RemoveBgCubitState {
  final Uint8List? removedBgImage;
  final String? originalImage;
  RemoveBgCubitState(
    this.removedBgImage, {
    required this.originalImage,
  });
}
