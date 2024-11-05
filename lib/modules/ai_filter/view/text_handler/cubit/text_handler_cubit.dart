import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/model/ai_image_text_model.dart';

class TextHandlerCubit extends Cubit<TextHandlerCubitState> {
  TextHandlerCubit() : super(TextHandlerCubitState(_default));

  static const _default = AiImageTextModel(
    text: "Your Text",
    textStyle: TextStyle(fontSize: 25),
    position: Offset.zero,
    rotate: Offset.zero,
    isEditing: false,
  );

  void updateTextStyle(TextStyle textStyle) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(textStyle: textStyle),
    ));
  }

  void updateText(String text) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(text: text),
    ));
  }

  void updateRotation(Offset rotate) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(rotate: rotate),
    ));
  }

  void updatePosition(Offset pos) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(position: pos),
    ));
  }

  void isEditing(bool isEditing) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(isEditing: isEditing),
    ));
  }

  void resetState() {
    emit(TextHandlerCubitState(_default));
  }
}
