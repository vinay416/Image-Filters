import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'color_filter_cubit_state.dart';

class ColorFilterCubit extends Cubit<ColorFilterCubitState> {
  ColorFilterCubit() : super(_defaultState);

  static final _defaultState = ColorFilterCubitState(null, 0);

  void onIndexChange(int index) {
    emit(state.copyWith(
      index: index,
      selectedColor: state.selectedColor,
    ));
  }

  void onColorChange(Color? color, PageController controller) async {
    if (color == null) {
      await animateScroll(controller, 0);
      emit(state.copyWith(selectedColor: color, index: 0));
    } else {
      emit(state.copyWith(selectedColor: color));
    }
  }

  Future<void> animateScroll(PageController controller, int index) async {
    await controller.animateToPage(
      0,
      duration: Durations.medium2,
      curve: Curves.decelerate,
    );
  }

  void resetState() => emit(_defaultState);
}
