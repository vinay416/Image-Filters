import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/gradient_mask/gradint_filters.dart';
import 'package:image_filters/views/mask_filters/mask_filter_colors_icon.dart';
import 'package:image_filters/views/mask_filters/mask_image_preview.dart';
import 'package:image_filters/screenshot/widget_screenshot.dart';

class GradientMaskFilter extends StatefulWidget {
  const GradientMaskFilter({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  State<GradientMaskFilter> createState() => _GradientMaskFilterState();
}

class _GradientMaskFilterState extends State<GradientMaskFilter> {
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
            MaskImagePreview(
              ssController: ssController,
              colors: colors,
              isSelected: isSelected,
              imageFile: imageFile,
            ),
            MaskFilterColorsIcon(colors: colors),
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
