import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/color_filter/widget/color_filter_preview.dart';

import 'widget/image_color_filters.dart';

class ImageColorFiltersView extends StatefulWidget {
  const ImageColorFiltersView({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<ImageColorFiltersView> createState() => _ImageColorFiltersViewState();
}

class _ImageColorFiltersViewState extends State<ImageColorFiltersView> {
  final controller = PageController(viewportFraction: 0.8);
  final blendModes = [
    BlendMode.color,
    BlendMode.colorBurn,
    BlendMode.colorDodge,
    BlendMode.darken,
    BlendMode.difference,
    BlendMode.hardLight,
    BlendMode.hue,
    BlendMode.lighten,
    BlendMode.multiply,
    BlendMode.overlay,
    BlendMode.plus,
    BlendMode.saturation,
    BlendMode.softLight,
  ];
  int selectedIndex = 0;
  Color? filterColor;
  late FileImage imageFile;
  late WidgetSSController ssController;

  @override
  void initState() {
    super.initState();
    ssController = WidgetSSController(widget.imagePath);
  }

  @override
  void didChangeDependencies() {
    imageFile = FileImage(File(widget.imagePath));
    precacheImage(imageFile, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: PageView.builder(
            controller: controller,
            itemCount: filterColor == null ? 1 : blendModes.length,
            onPageChanged: (value) {
              selectedIndex = value;
              setState(() {});
            },
            itemBuilder: (context, index) {
              final blendMode = blendModes[index];
              final isSelected = selectedIndex == index;

              return ColorFilterPreview(
                ssController: ssController,
                blendMode: blendMode,
                isSelected: isSelected,
                filterColor: filterColor,
                imageFile: imageFile,
              );
            },
          ),
        ),
        Flexible(
          child: ColorFilterPicker(
            selectedColor: filterColor,
            onColorChanged: (p0) => setState(
              () {
                filterColor = p0;
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
