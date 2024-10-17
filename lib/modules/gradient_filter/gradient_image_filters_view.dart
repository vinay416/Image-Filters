import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/gradient_filter/gradient_mask/gradint_filters.dart';
import 'package:image_filters/modules/gradient_filter/widget/gradient_filter_colors_icon.dart';
import 'package:image_filters/modules/gradient_filter/widget/gradient_image_preview.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';

import 'cubit/gradient_filter_cubit.dart';

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
  late FileImage imageFile;
  late WidgetSSController ssController;
  late GradientFilterCubit cubit;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    cubit = context.read<GradientFilterCubit>();
    controller = PageController(
      viewportFraction: 0.8,
      initialPage: cubit.state.filterIndex,
    );
    cubit.setPageController(controller);
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
    return BlocBuilder<GradientFilterCubit, GradientFilterCubitState>(
      builder: (context, state) {
        final selectedIndex = state.filterIndex;

        return PageView.builder(
          controller: controller,
          itemCount: GradintFilters.filters.length,
          onPageChanged: cubit.setSelectedIndex,
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
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
