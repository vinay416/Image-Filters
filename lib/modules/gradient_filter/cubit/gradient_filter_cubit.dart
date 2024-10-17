import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gradient_filter_cubit_state.dart';

class GradientFilterCubit extends Cubit<GradientFilterCubitState> {
  GradientFilterCubit() : super(_defaultState);
  late PageController controller;

  void setPageController(PageController controller) {
    this.controller = controller;
  }

  static final _defaultState = GradientFilterCubitState(0);

  void setSelectedIndex(int selectedIndex) {
    emit(GradientFilterCubitState(selectedIndex));
  }

  void setGradientColorIndex(int selectedIndex) async {
    await _animateScroll(selectedIndex);
    emit(GradientFilterCubitState(selectedIndex));
  }

  void resetState() {
    _animateScroll(_defaultState.filterIndex);
    emit(_defaultState);
  }

  Future<void> _animateScroll(int index) async {
    await controller.animateToPage(
      index,
      duration: Durations.medium2,
      curve: Curves.decelerate,
    );
  }
}
