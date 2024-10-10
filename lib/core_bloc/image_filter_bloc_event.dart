part of 'image_filter_bloc.dart';

sealed class ImageFilterBlocEvent {}

final class TabbarEvent extends ImageFilterBlocEvent {
  final FilterTabBar tabBar;
  TabbarEvent(this.tabBar);
}

final class PickFromGalleryEvent extends ImageFilterBlocEvent {}

final class PickFromCameraEvent extends ImageFilterBlocEvent {}

final class AddSaveControllerEvent extends ImageFilterBlocEvent {
  final WidgetSSController controller;
  AddSaveControllerEvent(this.controller);
}

final class SaveImageEvent extends ImageFilterBlocEvent {}
