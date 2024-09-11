import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_filters/core/image_camera_permission_mixin.dart';
import 'package:image_filters/core/image_service.dart';
import 'package:image_filters/screenshot/widget_screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

part 'image_filter_bloc_event.dart';
part 'image_filter_bloc_states.dart';

class ImageFilterBloc extends Bloc<ImageFilterBlocEvent, ImageFilterBlocStates>
    with ImageService, ImageCameraPermissionMixin {
  ImageFilterBloc() : super(ImageEmptyState()) {
    on<PickFromGalleryEvent>(_pickImageGallery);
    on<PickFromCameraEvent>(_pickImageCamera);
    on<AddSaveControllerEvent>(_onSSControllerAddEvent);
    on<SaveImageEvent>(_saveImage);
  }

  void _pickImageGallery(
    PickFromGalleryEvent event,
    Emitter<ImageFilterBlocStates> emit,
  ) async {
    emit(LoadingState(true));
    final status = await isImagePermissionGranted();
    if (status == PermissionStatus.permanentlyDenied) {
      emit(PermissionErrorState());
      return;
    }
    final (path, _) = await openGallery();
    if (path == null) {
      Fluttertoast.showToast(msg: "Image pick failed/canceled.");
      emit(ImageEmptyState());
      return;
    }
    emit(ImageFiltersState(path));
  }

  void _pickImageCamera(
    PickFromCameraEvent event,
    Emitter<ImageFilterBlocStates> emit,
  ) async {
    emit(LoadingState(true));
    final status = await isCameraPermissionGranted();
    if (status == PermissionStatus.permanentlyDenied) {
      emit(PermissionErrorState());
      return;
    }
    final (path, _) = await openCamera();
    if (path == null) {
      Fluttertoast.showToast(msg: "Image pick failed/canceled.");
      emit(ImageEmptyState());
      return;
    }
    emit(ImageFiltersState(path));
  }

  late WidgetSSController _controller;

  void _onSSControllerAddEvent(AddSaveControllerEvent event, _) {
    _controller = event.controller;
  }

  void _saveImage(
    SaveImageEvent event,
    Emitter<ImageFilterBlocStates> emit,
  ) async {
    emit(LoadingState(true));
    final file = await _controller.takeScreenShot();
    if (file == null) {
      Fluttertoast.showToast(msg: "Saving image failed");
    }
    emit(LoadingState(false));
  }
}
