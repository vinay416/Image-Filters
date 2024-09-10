import 'package:flutter/material.dart';
import 'package:image_filters/gradient_mask/gradient_mask.dart';
import 'package:image_filters/views/mask_filters/mask_image_preview.dart';
import 'package:image_filters/screenshot/widget_screenshot.dart';

class GradientMaskFilter extends StatefulWidget {
  const GradientMaskFilter({
    super.key,
  });

  @override
  State<GradientMaskFilter> createState() => _GradientMaskFilterState();
}

class _GradientMaskFilterState extends State<GradientMaskFilter> {
  final WidgetSSController controller = WidgetSSController();
  bool loading = false;

  void setLoader(bool status) {
    loading = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetScreenshot(
              controller: controller,
              child: const GradientMask(
                child: ImageCard(),
              ),
            ),
            buildGradientText(),
            buildSaveButton(),
          ],
        ),
        if (loading) buildLoader(),
      ],
    );
  }

  Container buildLoader() {
    return Container(
      color: Colors.black45,
      height: double.infinity,
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        setLoader(true);
        await controller.takeScreenShot();
        setLoader(false);
      },
      child: const Text('SAVE IMAGE'),
    );
  }

  GradientMask buildGradientText() {
    return const GradientMask(
      child: Text(
        "Gradient filter",
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}
