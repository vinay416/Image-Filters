import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ImageToolsEnum {
  textSize(Icons.format_size_rounded),
  fontFamily(Icons.style_rounded),
  textColor(Icons.colorize_rounded),
  rotateX(Icons.panorama_horizontal_rounded),
  rotateY(Icons.panorama_vertical_rounded),
  depthEffect(CupertinoIcons.view_3d);

  final IconData icon;
  const ImageToolsEnum(this.icon);
}

class ImageToolsCubit extends Cubit<ImageToolsEnum> {
  ImageToolsCubit() : super(ImageToolsEnum.textSize);

  void onTap(ImageToolsEnum option) {
    emit(option);
  }

  void reset() => emit(ImageToolsEnum.textSize);
}
