import 'package:flutter/material.dart';

class GradientMask extends StatelessWidget {
  const GradientMask({super.key, this.child, required this.colors});
  final Widget? child;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return colors.isEmpty
        ? child ?? const SizedBox.shrink()
        : ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: colors,
                stops: const [
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
