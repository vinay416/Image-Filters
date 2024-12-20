import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/color_filter/cubit/color_filter_cubit.dart';
import 'package:image_filters/modules/color_filter/cubit/color_filter_cubit_state.dart';
import 'package:image_filters/modules/pick_image/model/image_pick_model.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/color_filter/widget/color_filter_preview.dart';

import 'widget/image_color_filters.dart';

class ImageColorFiltersView extends StatefulWidget {
  const ImageColorFiltersView({super.key, required this.image});
  final ImagePickModel image;

  @override
  State<ImageColorFiltersView> createState() => _ImageColorFiltersViewState();
}

class _ImageColorFiltersViewState extends State<ImageColorFiltersView> {
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
  late PageController controller;
  late FileImage imageFile;
  late WidgetSSController ssController;
  final List<Color> colors = [Colors.transparent, ...Colors.primaries];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ColorFilterCubit>().state;
    controller = PageController(
      viewportFraction: 0.9,
      initialPage: cubit.index,
    );
    ssController = WidgetSSController(widget.image);
  }

  @override
  void didChangeDependencies() {
    precache();
    super.didChangeDependencies();
  }

  void precache() {
    imageFile = FileImage(File(widget.image.path));
    precacheImage(imageFile, context);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ColorFilterCubit>();

    return BlocBuilder<ColorFilterCubit, ColorFilterCubitState>(
      builder: (context, state) {
        final filterColor = state.selectedColor;
        final selectedIndex = state.index;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: PageView.builder(
                clipBehavior: Clip.none,
                controller: controller,
                itemCount: filterColor == null ? 1 : blendModes.length,
                onPageChanged: cubit.onIndexChange,
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
                key: ValueKey(filterColor),
                colors: colors,
                selectedColor: filterColor,
                onColorChanged: (color) {
                  cubit.onColorChange(color, controller);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
