import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ImageToolsEnum {
  textSize(Icons.format_size_rounded, "Size"),
  fontFamily(Icons.style_rounded, "Style"),
  textColor(Icons.colorize_rounded, "Color"),
  rotateX(Icons.panorama_horizontal_rounded, "Horizontal"),
  rotateY(Icons.panorama_vertical_rounded, "Vertical"),
  depthEffect(Icons.portrait_rounded, "Blur");

  final IconData icon;
  final String label;
  const ImageToolsEnum(this.icon, this.label);
}

class ImageToolsCubit extends Cubit<ImageToolsEnum> {
  ImageToolsCubit() : super(ImageToolsEnum.textSize);

  void onTap(ImageToolsEnum option) {
    emit(option);
  }

  void reset() => emit(ImageToolsEnum.textSize);
}
