import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({
    super.key,
    required this.onTap,
    this.bgColor,
    required this.icon,
    this.iconColor,
    this.iconSize,
    this.isExtent = false,
    this.extentLabel = 'Label',
  });
  final VoidCallback? onTap;
  final Color? bgColor;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final bool isExtent;
  final String extentLabel;

  @override
  Widget build(BuildContext context) {
    final shape = isExtent ? BoxShape.rectangle : BoxShape.circle;
    final borderRadius = isExtent ? BorderRadius.circular(25) : null;
    final crossFadeState =
        isExtent ? CrossFadeState.showSecond : CrossFadeState.showFirst;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        customBorder: isExtent ? const StadiumBorder() : const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: bgColor ?? Colors.black,
            shape: shape,
            borderRadius: borderRadius,
            border: Border.all(color: Colors.grey),
          ),
          child: AnimatedCrossFade(
            alignment: Alignment.center,
            duration: Durations.medium2,
            crossFadeState: crossFadeState,
            secondChild: Row(children: [buildIcon(), buildLabel()]),
            firstChild: buildIcon(),
          ),
        ),
      ),
    );
  }

  Widget buildIcon() {
    return Icon(
      icon,
      size: iconSize ?? 35,
      color: iconColor ?? Colors.white,
    );
  }

  Widget buildLabel() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        extentLabel,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
