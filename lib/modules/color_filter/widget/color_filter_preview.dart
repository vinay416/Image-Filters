import 'package:flutter/material.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/screenshot/view/save_button.dart';

class ColorFilterPreview extends StatelessWidget {
  const ColorFilterPreview({
    super.key,
    required this.blendMode,
    required this.isSelected,
    required this.filterColor,
    required this.imageFile,
    required this.ssController,
  });
  final BlendMode blendMode;
  final bool isSelected;
  final Color? filterColor;
  final FileImage imageFile;
  final WidgetSSController ssController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
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
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Positioned.fill(
            child: WidgetScreenshot(
              controller: isSelected ? ssController : null,
              child: ColorFiltered(
                colorFilter: filterColor == null
                    ? ColorFilter.mode(Colors.transparent, blendMode)
                    : ColorFilter.mode(filterColor!, blendMode),
                child: Image(
                  fit: BoxFit.cover,
                  image: imageFile,
                ),
              ),
            ),
          ),
          if (isSelected) SaveButton(controller: ssController),
        ],
      ),
    );
  }
}
