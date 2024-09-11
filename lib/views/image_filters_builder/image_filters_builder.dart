import 'package:flutter/material.dart';
import 'package:image_filters/filters/image_blend_filters.dart';

class ImageFiltersBuilder extends StatelessWidget {
  const ImageFiltersBuilder({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ImageBlendFilters(imagePath: imagePath);
  }
}
