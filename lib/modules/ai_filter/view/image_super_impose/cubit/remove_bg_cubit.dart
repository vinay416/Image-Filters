import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core/overlay_loader_mixin.dart';
import 'package:image_filters/modules/ai_filter/services/ai_image_api_services.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit_state.dart';

class RemoveBgCubit extends Cubit<RemoveBgCubitState> with OverlayLoaderMixin {
  RemoveBgCubit() : super(_default);

  static final _default = RemoveBgCubitState(null, originalImage: null);

  Future<void> removeBg(String originalImage) async {
    try {
      insertFullLoader();
      final response = await AiImageApiServices().removeBgApi(
        originalImage,
      );
      emit(RemoveBgCubitState(
        response,
        originalImage: originalImage,
      ));
      removeFullLoader();
    } catch (e) {
      log("Error -> remove image BG API $e");
      emit(_default);
      removeFullLoader();
    }
  }

  void reset() => emit(_default);
}
