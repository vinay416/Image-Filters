import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_filters/core/overlay_loader_mixin.dart';
import 'package:image_filters/modules/ai_filter/services/ai_image_api_services.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit_state.dart';

class RemoveBgCubit extends Cubit<RemoveBgCubitState> with OverlayLoaderMixin {
  RemoveBgCubit() : super(_default);

  static final _default = RemoveBgCubitState(null, originalImage: null);

  Future<bool> removeBg(String originalImage) async {
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
      if (response.isEmpty) throw response;
      return response.isNotEmpty;
    } catch (e) {
      Fluttertoast.showToast(msg: "AI API failed, try later!");
      emit(_default);
      removeFullLoader();
      return false;
    }
  }

  void reset() => emit(_default);
}
