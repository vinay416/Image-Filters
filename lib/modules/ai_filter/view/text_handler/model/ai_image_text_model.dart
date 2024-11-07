// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AiImageTextModel {
  const AiImageTextModel({
    required this.text,
    required this.textStyle,
    required this.position,
    required this.rotate,
    required this.isEditing,
    required this.isFieldFocused,
  });
  final String text;
  final TextStyle textStyle;
  final Offset position;
  final Offset rotate;
  final bool isEditing;
  final bool isFieldFocused;

  AiImageTextModel copyWith({
    String? text,
    TextStyle? textStyle,
    Offset? position,
    Offset? rotate,
    bool? isEditing,
    bool? isFieldFocused,
  }) {
    return AiImageTextModel(
      text: text ?? this.text,
      textStyle: textStyle ?? this.textStyle,
      position: position ?? this.position,
      rotate: rotate ?? this.rotate,
      isEditing: isEditing ?? this.isEditing,
      isFieldFocused: isFieldFocused ?? this.isFieldFocused,
    );
  }
}
