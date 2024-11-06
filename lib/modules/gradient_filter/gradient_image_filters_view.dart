import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/gradient_filter/gradient_mask/gradint_filters.dart';
import 'package:image_filters/modules/gradient_filter/widget/gradient_image_preview.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'cubit/gradient_filter_cubit.dart';
import 'widget/gradient_filters_colors_list.dart';

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
  final colorListcontroller = AutoScrollController();

  @override
  void initState() {
    super.initState();
    cubit = context.read<GradientFilterCubit>();
    controller = PageController(
      viewportFraction: 0.9,
      initialPage: cubit.state.filterIndex,
    );
    cubit.setPageController(controller);
    cubit.setColorListController(colorListcontroller);
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

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: PageView.builder(
                clipBehavior: Clip.none,
                controller: controller,
                itemCount: GradintFilters.filters.length,
                onPageChanged: cubit.setSelectedIndex,
                itemBuilder: (context, index) {
                  final colors = GradintFilters.filters[index];
                  final isSelected = selectedIndex == index;

                  return GradientImagePreview(
                    ssController: ssController,
                    colors: colors,
                    isSelected: isSelected,
                    imageFile: imageFile,
                  );
                },
              ),
            ),
            Flexible(
              child: GradientFilterColorsList(
                controller: colorListcontroller,
                selectedIndex: selectedIndex,
                onColorChanged: cubit.setGradientColorIndex,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    colorListcontroller.dispose();
    super.dispose();
  }
}
