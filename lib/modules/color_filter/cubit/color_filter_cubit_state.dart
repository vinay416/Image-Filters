// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ColorFilterCubitState {
  ColorFilterCubitState(this.selectedColor, this.index);
  final Color? selectedColor;
  final int index;

  ColorFilterCubitState copyWith({
    Color? selectedColor,
    int? index,
  }) {
    return ColorFilterCubitState(
      selectedColor,
      index ?? this.index,
    );
  }
}
