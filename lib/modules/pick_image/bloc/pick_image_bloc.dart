import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_filters/core/overlay_loader_mixin.dart';
import 'package:image_filters/modules/pick_image/model/image_pick_model.dart';
import 'package:image_filters/modules/pick_image/services/image_camera_permission_mixin.dart';
import 'package:image_filters/modules/pick_image/services/image_picker_service.dart';
import 'package:image_filters/modules/pick_image/view/widget/image_pick_bottem_sheet.dart';
import 'package:permission_handler/permission_handler.dart';

part 'pick_image_bloc_event.dart';
part 'pick_image_bloc_state.dart';

class PickImageBloc extends Bloc<PickImageBlocEvent, PickImageBlocState>
    with ImagePickerService, ImageCameraPermissionMixin, OverlayLoaderMixin {
  PickImageBloc() : super(ImageEmptyState()) {
    on<PickImageBottomSheet>(_pickImageBottomSheet);
    on<PickImageFromGallery>(_pickImageGallery);
    on<PickImageFromCamera>(_pickImageCamera);
  }

  void _pickImageBottomSheet(
    PickImageBottomSheet event,
    Emitter<PickImageBlocState> emit,
  ) {
    ImagePickBottemSheet.show(event.context);
  }

  void _pickImageGallery(
    PickImageFromGallery event,
    Emitter<PickImageBlocState> emit,
  ) async {
    insertFullLoader();
    final status = await isImagePermissionGranted();
    if (status == PermissionStatus.permanentlyDenied) {
      removeFullLoader();
      emit(PickImagePermissionError());
      return;
    }
    final (image, _) = await openGallery();
    removeFullLoader();
    if (image == null) {
      Fluttertoast.showToast(msg: "Image pick failed/canceled.");
      return;
    }
    emit(PickImageResultState(image: image));
  }

  void _pickImageCamera(
    PickImageFromCamera event,
    Emitter<PickImageBlocState> emit,
  ) async {
    insertFullLoader();
    final status = await isCameraPermissionGranted();
    if (status == PermissionStatus.permanentlyDenied) {
      removeFullLoader();
      emit(PickImagePermissionError());
      return;
    }
    final (image, _) = await openCamera();
    removeFullLoader();
    if (image == null) {
      Fluttertoast.showToast(msg: "Image pick failed/canceled.");
      return;
    }
    emit(PickImageResultState(image: image));
  }
}
