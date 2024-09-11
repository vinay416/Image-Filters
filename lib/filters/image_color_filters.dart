import 'package:flutter/material.dart';

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
  late Color selectedColor;
  final List<Color> colors = [Colors.transparent, ...Colors.primaries];

  @override
  void initState() {
    selectedColor = widget.selectedColor ?? colors.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final bool isSelected = selectedColor == colors[index];

        return InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            selectedColor = colors[index];
            setState(() {});
            final callbackColor = index==0? null: selectedColor;
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
              child: index == 0
                  ? const Text(
                      "NONE",
                      style: TextStyle(color: Colors.grey),
                    )
                  : null,
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
}
