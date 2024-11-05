import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/common/card_decoration.dart';
import 'package:image_filters/modules/ai_filter/view/image_preview/cubit/ai_image_fit_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/view/text_position_handler.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'package:image_filters/modules/screenshot/view/save_button.dart';

import '../../image_super_impose/view/image_super_impose.dart';
import '../../text_handler/view/text_position_widget.dart';
import 'ai_image_fit_icon_button.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AiImageFitIconButton(),
                SaveButton(controller: ssController),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStack() {
    return BlocBuilder<AiImageFitCubit, BoxFit>(
      builder: (context, fit) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image(
                fit: fit,
                image: imageFile,
              ),
            ),
            const TextPositionWidget(),
            Positioned.fill(
              child: ImageSuperImpose(fit: fit),
            ),
            const TextPositionHandler(),
          ],
        );
      },
    );
  }
}
