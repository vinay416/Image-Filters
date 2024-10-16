import 'package:flutter/material.dart';
import 'package:image_filters/common/card_decoration.dart';
import 'package:image_filters/modules/gradient_filter/gradient_mask/gradient_mask.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/screenshot/view/save_button.dart';

class GradientImagePreview extends StatelessWidget {
  const GradientImagePreview({
    super.key,
    required this.isSelected,
    required this.imageFile,
    required this.colors,
    required this.ssController,
  });
  final bool isSelected;
  final FileImage imageFile;
  final List<Color> colors;
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
              child: GradientMask(
                colors: colors,
                child: Image(
                  fit: BoxFit.cover,
                  image: imageFile,
                ),
              ),
            ),
          ),
          if (isSelected && colors.isNotEmpty)
            SaveButton(controller: ssController),
        ],
      ),
    );
  }
}
