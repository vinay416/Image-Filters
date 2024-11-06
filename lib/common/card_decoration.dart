import 'package:flutter/material.dart';

class CardDecoration extends StatelessWidget {
  const CardDecoration({
    super.key,
    this.child,
    this.isSelected = true,
  });
  final Widget? child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: isSelected
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 5),
            blurRadius: 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: child,
      ),
    );
  }
}
