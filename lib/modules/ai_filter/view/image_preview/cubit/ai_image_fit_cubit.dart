import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiImageFitCubit extends Cubit<BoxFit> {
  AiImageFitCubit() : super(_default);

  static const _default = BoxFit.cover;

  void toggleFit() {
    if (state == BoxFit.contain) {
      emit(BoxFit.cover);
      return;
    }
    emit(BoxFit.contain);
  }

  void reset() => emit(_default);
}
