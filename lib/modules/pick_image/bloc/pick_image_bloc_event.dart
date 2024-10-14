part of 'pick_image_bloc.dart';

abstract class PickImageBlocEvent {}

class PickImageBottomSheet extends PickImageBlocEvent {
  PickImageBottomSheet(this.context);
  final BuildContext context;
}

class PickImageFromCamera extends PickImageBlocEvent {}

class PickImageFromGallery extends PickImageBlocEvent {}
