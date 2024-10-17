import 'package:flutter/material.dart';
import 'package:image_filters/common/card_decoration.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/screenshot/view/save_button.dart';

class AiImagePreview extends StatelessWidget {
  const AiImagePreview({
    super.key,
    required this.imageFile,
    required this.ssController,
  });
  final FileImage imageFile;
  final WidgetSSController ssController;

  @override
  Widget build(BuildContext context) {
    return CardDecoration(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned.fill(
              child: WidgetScreenshot(
                controller: ssController,
                child: Image(
                  fit: BoxFit.cover,
                  image: imageFile,
                ),
              ),
            ),
            SaveButton(controller: ssController),
          ],
        ),
      ),
    );
  }
}
