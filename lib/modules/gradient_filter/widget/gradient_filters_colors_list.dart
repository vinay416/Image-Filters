import 'package:flutter/material.dart';
import 'package:image_filters/modules/gradient_filter/gradient_mask/gradint_filters.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'gradient_filter_colors_icon.dart';

class GradientFilterColorsList extends StatelessWidget {
  const GradientFilterColorsList({
    super.key,
    required this.onColorChanged,
    required this.selectedIndex,
    required this.controller,
  });
  final void Function(int) onColorChanged;
  final int selectedIndex;
  final AutoScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final bool isSelected = selectedIndex == index;

        return AutoScrollTag(
          key: ValueKey(index),
          index: index,
          controller: controller,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              onColorChanged(index);
            },
            child: GradientFilterColorsIcon(
              isSelected: isSelected,
              colors: GradintFilters.filters[index],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 10);
      },
      itemCount: GradintFilters.filters.length,
    );
  }
}
