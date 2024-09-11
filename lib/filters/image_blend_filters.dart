import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/filters/image_color_filters.dart';
import 'package:image_filters/screenshot/widget_screenshot.dart';

class ImageBlendFilters extends StatefulWidget {
  const ImageBlendFilters({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<ImageBlendFilters> createState() => _ImageBlendFiltersState();
}

class _ImageBlendFiltersState extends State<ImageBlendFilters> {
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
  final ssController = WidgetSSController();
  late ImageFilterBloc imageFilterBloc;

  @override
  void initState() {
    super.initState();
    imageFilterBloc = context.read<ImageFilterBloc>();
    imageFilterBloc.add(AddSaveControllerEvent(ssController));
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

              return CardItem(
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

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.blendMode,
    required this.isSelected,
    required this.filterColor,
    required this.imageFile,
    required this.ssController,
  });
  final BlendMode blendMode;
  final bool isSelected;
  final Color? filterColor;
  final FileImage imageFile;
  final WidgetSSController ssController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: isSelected
          ? const EdgeInsets.symmetric(vertical: 16, horizontal: 8)
          : const EdgeInsets.symmetric(vertical: 38, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      child: WidgetScreenshot(
        controller: isSelected ? ssController : null,
        child: ColorFiltered(
          colorFilter: filterColor == null
              ? ColorFilter.mode(Colors.transparent, blendMode)
              : ColorFilter.mode(filterColor!, blendMode),
          child: Image(
            fit: BoxFit.cover,
            image: imageFile,
          ),
        ),
      ),
    );
  }
}
