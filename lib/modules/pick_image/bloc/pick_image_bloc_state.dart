part of 'pick_image_bloc.dart';

abstract class PickImageBlocState {}

class ImageEmptyState extends PickImageBlocState {}

class PickImageResultState extends PickImageBlocState {
  final String imagePath;
  PickImageResultState({
    required this.imagePath,
  });
}

class PickImagePermissionError extends PickImageBlocState {}

