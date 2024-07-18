import 'package:flutter/material.dart';
import 'package:image_filters/screenshot/widget_screenshot.dart';

class MaskFilters extends StatelessWidget {
  const MaskFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientMaskFilter();
  }
}

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
            const GradientMask(
              child: Text(
                "Gradient filter",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setLoader(true);
                await controller.takeScreenShot();
                setLoader(false);
              },
              child: const Text('SAVE IMAGE'),
            ),
          ],
        ),
        if (loading)
          Container(
            color: Colors.black45,
            height: double.infinity,
            width: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 6),
            blurRadius: 8,
          ),
        ],
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?cs=srgb&dl=pexels-chloekalaartist-1043474.jpg&fm=jpg',
          ),
        ),
      ),
    );
  }
}

class GradientMask extends StatelessWidget {
  const GradientMask({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [
            Colors.green,
            Colors.red,
            Colors.blue,
          ],
          stops: [
            0.25,
            0.55,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
