part of 'image_filter_bloc.dart';

sealed class ImageFilterBlocEvent {}

final class PickFromGalleryEvent extends ImageFilterBlocEvent {}

final class PickFromCameraEvent extends ImageFilterBlocEvent {}

final class SaveImageEvent extends ImageFilterBlocEvent {
  SaveImageEvent(this.controller);
  final WidgetSSController controller;
}

