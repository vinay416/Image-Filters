import 'package:flutter/material.dart';

class GradientFilterColorsIcon extends StatelessWidget {
  const GradientFilterColorsIcon({
    super.key,
    required this.colors,
    required this.isSelected,
  });
  final List<Color> colors;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(
                strokeAlign: BorderSide.strokeAlignOutside,
                width: 5,
                color: Colors.grey,
              )
            : null,
        gradient: colors.isEmpty
            ? null
            : LinearGradient(
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
      child: colors.isEmpty
          ? const Center(
              child: Text(
                "NONE",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            )
          : null,
    );
  }
}
