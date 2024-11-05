import 'package:flutter/material.dart';
import 'package:image_filters/common/card_decoration.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/view/text_position_handler.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/screenshot/view/save_button.dart';

import '../image_super_impose/view/image_super_impose.dart';
import '../text_handler/view/text_position_widget.dart';

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
                child: buildStack(),
              ),
            ),
            SaveButton(controller: ssController),
          ],
        ),
      ),
    );
  }

  Widget buildStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Image(
            fit: BoxFit.contain,
            image: imageFile,
          ),
        ),
        const TextPositionWidget(),
        const Positioned.fill(
          child: ImageSuperImpose(),
        ),
        const TextPositionHandler(),
      ],
    );
  }

  // Widget buildSuperImpose(){

  // }
}
