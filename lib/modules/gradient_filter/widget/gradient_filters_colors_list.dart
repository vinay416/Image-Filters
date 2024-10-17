import 'package:flutter/material.dart';
import 'package:image_filters/modules/gradient_filter/gradient_mask/gradint_filters.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'gradient_filter_colors_icon.dart';

class GradientFilterColorsList extends StatefulWidget {
  const GradientFilterColorsList({
    super.key,
    required this.onColorChanged,
    required this.selectedIndex,
  });
  final void Function(int) onColorChanged;
  final int selectedIndex;

  @override
  State<GradientFilterColorsList> createState() =>
      _GradientFilterColorsListState();
}

class _GradientFilterColorsListState extends State<GradientFilterColorsList> {
  final AutoScrollController controller = AutoScrollController();
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.scrollToIndex(
      selectedIndex,
      duration: const Duration(milliseconds: 200),
      preferPosition: AutoScrollPosition.middle,
    );
    super.didChangeDependencies();
  }

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
              selectedIndex = index;
              setState(() {});
              widget.onColorChanged(selectedIndex);
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
