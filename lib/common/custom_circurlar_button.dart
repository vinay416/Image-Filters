import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({
    super.key,
    required this.onTap,
    this.bgColor,
    required this.icon,
    this.iconColor,
    this.iconSize,
  });
  final VoidCallback onTap;
  final Color? bgColor;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: bgColor ?? Colors.black,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: Icon(
            icon,
            size: iconSize ?? 35,
            color: iconColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
