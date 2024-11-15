part of 'pick_image_bloc.dart';

abstract class PickImageBlocState {}

class ImageEmptyState extends PickImageBlocState {}

class PickImageResultState extends PickImageBlocState {
  final ImagePickModel image;
  PickImageResultState({
    required this.image,
  });
}

class PickImagePermissionError extends PickImageBlocState {}

