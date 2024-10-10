import 'package:flutter/material.dart';

class MaskFilterColorsIcon extends StatelessWidget {
  const MaskFilterColorsIcon({super.key, required this.colors});
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          stops: const [
            0.25,
            0.55,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.mirror,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
