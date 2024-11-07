import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/model/ai_image_text_model.dart';

class TextHandlerCubit extends Cubit<TextHandlerCubitState> {
  TextHandlerCubit() : super(TextHandlerCubitState(_default));

  static const _default = AiImageTextModel(
    text: "Your Text",
    textStyle: TextStyle(
      fontSize: 50,
      color: Colors.white,
    ),
    position: Offset.zero,
    rotate: Offset.zero,
    isEditing: false,
    isFieldFocused: true,
  );

  void updateTextStyle(TextStyle textStyle) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(textStyle: textStyle),
    ));
  }

  void onChangeText(String text) {
    final newText = text.trim();
    final updatedText = newText.isEmpty ? _default.text : newText;
    emit(TextHandlerCubitState(
      state.textModel.copyWith(text: updatedText),
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

  void isFieldFocused(bool focused) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(isFieldFocused: focused),
    ));
  }

  void resetState() {
    emit(TextHandlerCubitState(_default));
  }
}
