import 'package:flutter/material.dart';
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
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
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
              child: GradientMask(
                colors: colors,
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
