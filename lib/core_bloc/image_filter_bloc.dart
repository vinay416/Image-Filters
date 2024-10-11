import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_filters/core/image_camera_permission_mixin.dart';
import 'package:image_filters/core/image_service.dart';
import 'package:image_filters/screenshot/widget_screenshot.dart';
import 'package:image_filters/tabbar/home_filter_tab_bar.dart';
import 'package:permission_handler/permission_handler.dart';

part 'image_filter_bloc_event.dart';
part 'image_filter_bloc_states.dart';

class ImageFilterBloc extends Bloc<ImageFilterBlocEvent, ImageFilterBlocStates>
    with ImageService, ImageCameraPermissionMixin {
  ImageFilterBloc() : super(ImageEmptyState()) {
    on<PickFromGalleryEvent>(_pickImageGallery);
    on<PickFromCameraEvent>(_pickImageCamera);
    on<TabbarEvent>(_onTabBarChange);
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
      emit(LoadingState(false));
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
      emit(LoadingState(false));

      return;
    }
    emit(ImageFiltersState(path));
  }

  late WidgetSSController _controller;

  void _onSSControllerAddEvent(AddSaveControllerEvent event, _) {
    _controller = event.controller;
  }

  FilterTabBar _tabBar = FilterTabBar.colors;
  FilterTabBar get tabBar => _tabBar;

  void _onTabBarChange(
    TabbarEvent event,
    Emitter<ImageFilterBlocStates> emit,
  ) {
    emit(TabViewState(event.tabBar));
    _tabBar = event.tabBar;
  }

  void _saveImage(
    SaveImageEvent event,
    Emitter<ImageFilterBlocStates> emit,
  ) async {
    emit(LoadingState(true));
    await Future.delayed(Durations.extralong4);
    final file = await _controller.takeScreenShot();
    if (file == null) {
      Fluttertoast.showToast(msg: "Saving image failed");
    } else {
      Fluttertoast.showToast(msg: "Image Saved");
    }
    emit(LoadingState(false));
  }
}
