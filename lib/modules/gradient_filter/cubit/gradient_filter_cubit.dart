import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

part 'gradient_filter_cubit_state.dart';

class GradientFilterCubit extends Cubit<GradientFilterCubitState> {
  GradientFilterCubit() : super(_defaultState);
  late PageController controller;
  late AutoScrollController colorListcontroller;

  void setPageController(PageController controller) {
    this.controller = controller;
  }

  void setColorListController(AutoScrollController controller) {
    colorListcontroller = controller;
  }

  static final _defaultState = GradientFilterCubitState(0);

  void setSelectedIndex(int selectedIndex) async {
    await _animateColoListScroll(selectedIndex);
    emit(GradientFilterCubitState(selectedIndex));
  }

  void setGradientColorIndex(int selectedIndex) async {
    _animateScroll(selectedIndex);
    emit(GradientFilterCubitState(selectedIndex));
  }

  void resetState() {
    _animateScroll(_defaultState.filterIndex);
    _animateColoListScroll(_defaultState.filterIndex);
    emit(_defaultState);
  }

  Future<void> _animateColoListScroll(int index) async {
    colorListcontroller.scrollToIndex(
      index,
      duration: const Duration(milliseconds: 300),
      preferPosition: AutoScrollPosition.middle,
    );
  }

  Future<void> _animateScroll(int index) async {
    await controller.animateToPage(
      index,
      duration: Durations.medium2,
      curve: Curves.decelerate,
    );
  }
}
