import 'package:flutter/material.dart';
import 'package:image_filters/common/card_decoration.dart';
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
    return CardDecoration(
      isSelected: isSelected,
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
          if (isSelected && filterColor != null)
            SaveButton(controller: ssController),
        ],
      ),
    );
  }
}
