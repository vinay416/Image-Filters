import 'package:flutter/material.dart';
import 'package:image_filters/gradient_mask/gradint_filters.dart';

class GradientMask extends StatelessWidget {
  const GradientMask({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: GradintFilters.christmas,
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
