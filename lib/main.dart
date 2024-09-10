import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/views/image_filters_builder/image_filters_builder.dart';
import 'package:image_filters/views/image_pick_view/image_pick_view.dart';
import 'package:image_filters/views/permission_error/permission_error_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageFilterBloc(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Image Editor"),
          ),
          // body: ImageBlendFilters(),
          // body: GradientMaskFilter(),
          // body: ImagePickView(),
          body: Stack(
            children: [
              buildBody(),
              buildLoader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoader() {
    return BlocSelector<ImageFilterBloc, ImageFilterBlocStates, LoadingState>(
      selector: (state) {
        if (state is LoadingState) return state;
        return LoadingState(false);
      },
      builder: (context, state) {
        if (state.loading) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildBody() {
    return BlocBuilder<ImageFilterBloc, ImageFilterBlocStates>(
      builder: (context, state) {
        if (state is PermissionErrorState) {
          return const PermissionErrorView();
        }
        if (state is ImageFiltersState) {
          return ImageFiltersBuilder(imagePath: state.path);
        }
        return const ImagePickView();
      },
    );
  }
}
