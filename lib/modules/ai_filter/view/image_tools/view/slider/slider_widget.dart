import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.onChange,
    required this.selectedValue,
    required this.min,
    required this.max,
  });
  final Function(double value) onChange;
  final double selectedValue;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorShape: DropSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.black,
        valueIndicatorStrokeColor: Colors.blue,
        valueIndicatorTextStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        activeTrackColor: Colors.blue,
        thumbColor: Colors.black,
      ),
      child: Slider(
        onChanged: onChange,
        label: selectedValue.toStringAsFixed(2),
        min: min,
        max: max,
        value: selectedValue,
      ),
    );
  }
}
