part of 'image_filter_bloc.dart';

sealed class ImageFilterBlocStates {}

final class LoadingState extends ImageFilterBlocStates {
  LoadingState(this.loading);
  final bool loading;
}

final class ImageEmptyState extends ImageFilterBlocStates {}

final class PermissionErrorState extends ImageFilterBlocStates {}

final class ImageFiltersState extends ImageFilterBlocStates {
  ImageFiltersState(this.path);
  final String path;
}
