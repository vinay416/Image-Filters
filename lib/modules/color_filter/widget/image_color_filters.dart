import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ColorFilterPicker extends StatefulWidget {
  const ColorFilterPicker({
    super.key,
    required this.onColorChanged,
    required this.selectedColor,
  });
  final void Function(Color?) onColorChanged;
  final Color? selectedColor;

  @override
  State<ColorFilterPicker> createState() => _ColorFilterPickerState();
}

class _ColorFilterPickerState extends State<ColorFilterPicker> {
  final AutoScrollController controller = AutoScrollController();
  late Color selectedColor;
  final List<Color> colors = [Colors.transparent, ...Colors.primaries];

  @override
  void initState() {
    selectedColor = widget.selectedColor ?? colors.first;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller.scrollToIndex(
      colors.indexWhere((e) => e == selectedColor),
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
        final bool isSelected = selectedColor == colors[index];

        return AutoScrollTag(
          key: ValueKey(index),
          index: index,
          controller: controller,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              selectedColor = colors[index];
              setState(() {});
              final callbackColor = index == 0 ? null : selectedColor;
              widget.onColorChanged(callbackColor);
            },
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(2),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 5,
                  color: isSelected
                      ? (index == 0 ? Colors.grey : colors[index])
                      : Colors.transparent,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: colors[index],
                child: index == 0 ? const Text("NONE") : null,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 10);
      },
      itemCount: colors.length,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
