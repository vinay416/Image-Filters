import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ImageBlendFilters extends StatefulWidget {
  const ImageBlendFilters({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: PageView.builder(
            controller: controller,
            itemCount: blendModes.length,
            onPageChanged: (value) {
              selectedIndex = value;
              setState(() {});
            },
            itemBuilder: (context, index) {
              final blendMode = blendModes[index];
              final isSelected = selectedIndex == index;
              return CardItem(
                blendMode: blendMode,
                isSelected: isSelected,
                filterColor: filterColor,
              );
            },
          ),
        ),
        ColorFilterPicker(
          defaultColor: filterColor,
          onColorChanged: (p0) => setState(() {
            filterColor = p0;
          }),
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
  });

  final BlendMode blendMode;
  final bool isSelected;
  final Color? filterColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const NetworkImage(
            'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?cs=srgb&dl=pexels-chloekalaartist-1043474.jpg&fm=jpg',
          ),
          colorFilter: filterColor == null
              ? null
              : ColorFilter.mode(filterColor!, blendMode),
        ),
      ),
    );
  }
}

class ColorFilterPicker extends StatefulWidget {
  const ColorFilterPicker({
    super.key,
    required this.onColorChanged,
    required this.defaultColor,
  });
  final void Function(Color) onColorChanged;
  final Color? defaultColor;

  @override
  State<ColorFilterPicker> createState() => _ColorFilterPickerState();
}

class _ColorFilterPickerState extends State<ColorFilterPicker> {
  late Color screenPickerColor = widget.defaultColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(20),
          ),
          child: ColorPicker(
            color: screenPickerColor,
            onColorChanged: (Color color) {
              setState(() => screenPickerColor = color);
              widget.onColorChanged(screenPickerColor);
            },
            width: 44,
            height: 44,
            borderRadius: 22,
            heading: Text(
              'Filter color',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subheading: Text(
              'Select color shade',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            enableShadesSelection: false,
            pickersEnabled: const {
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.bw: false,
              ColorPickerType.custom: false,
              ColorPickerType.wheel: false,
            },
          ),
        ),
      ),
    );
  }
}
