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
    isFieldFocused: false,
    isForegroundText: true,
    backgroundBlur: 0,
  );

  late ScrollController _toolsListScrollController;
  void setToolsListScrollController(
    ScrollController scrollController,
  ) {
    _toolsListScrollController = scrollController;
  }

  void updateTextSize(double size) {
    final newStyle = state.textModel.textStyle.copyWith(fontSize: size);
    emit(TextHandlerCubitState(
      state.textModel.copyWith(textStyle: newStyle),
    ));
  }

  void updateTextFamily(String? fontFamily) {
    final newStyle = state.textModel.textStyle.copyWith(fontFamily: fontFamily);
    emit(TextHandlerCubitState(
      state.textModel.copyWith(textStyle: newStyle),
    ));
  }

  void updateTextColor(Color? color) {
    final newStyle = state.textModel.textStyle.copyWith(
      color: color ?? Colors.white,
    );
    emit(TextHandlerCubitState(
      state.textModel.copyWith(textStyle: newStyle),
    ));
  }

  void onChangeText(String text) {
    final newText = text.trim();
    final updatedText = newText.isEmpty ? _default.text : newText;
    emit(TextHandlerCubitState(
      state.textModel.copyWith(text: updatedText),
    ));
  }

  void updateRotationX(double dx) {
    final oldOffset = state.textModel.rotate;
    emit(TextHandlerCubitState(
      state.textModel.copyWith(rotate: Offset(dx, oldOffset.dy)),
    ));
  }

  void updateRotationY(double dy) {
    final oldOffset = state.textModel.rotate;
    emit(TextHandlerCubitState(
      state.textModel.copyWith(rotate: Offset(oldOffset.dx, dy)),
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

  void toggleTextForeground(bool value) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(isForegroundText: !value),
    ));
  }

  void resetTextForeground() {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(isForegroundText: true),
    ));
  }

  void updateBackgroundBlur(double blur) {
    emit(TextHandlerCubitState(
      state.textModel.copyWith(backgroundBlur: blur),
    ));
  }

  void resetState() {
    _toolsListScrollController.jumpTo(0);
    emit(TextHandlerCubitState(_default));
  }
}
