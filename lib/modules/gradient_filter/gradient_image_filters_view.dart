import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/modules/gradient_filter/gradient_mask/gradint_filters.dart';
import 'package:image_filters/modules/gradient_filter/widget/gradient_filter_colors_icon.dart';
import 'package:image_filters/modules/gradient_filter/widget/gradient_image_preview.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';

class GradientImageFiltersView extends StatefulWidget {
  const GradientImageFiltersView({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  State<GradientImageFiltersView> createState() =>
      _GradientImageFiltersViewState();
}

class _GradientImageFiltersViewState extends State<GradientImageFiltersView> {
  int selectedIndex = 0;
  late FileImage imageFile;
  late WidgetSSController ssController;
  late ImageFilterBloc imageFilterBloc;
  final controller = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
    ssController = WidgetSSController(widget.imagePath);
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
    return PageView.builder(
      controller: controller,
      itemCount: GradintFilters.filters.length,
      onPageChanged: (value) {
        selectedIndex = value;
        setState(() {});
      },
      itemBuilder: (context, index) {
        final colors = GradintFilters.filters[index];
        final isSelected = selectedIndex == index;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GradientImagePreview(
              ssController: ssController,
              colors: colors,
              isSelected: isSelected,
              imageFile: imageFile,
            ),
            GradientFilterColorsIcon(colors: colors),
            const SizedBox(height: 10),
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
