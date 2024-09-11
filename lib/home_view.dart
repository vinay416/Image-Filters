import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/views/image_filters_builder/image_filters_builder.dart';
import 'package:image_filters/views/image_pick_view/image_pick_view.dart';
import 'package:image_filters/views/permission_error/permission_error_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Editor"),
        actions: [
          buildSaveButton(context),
          const SizedBox(width: 20),
        ],
      ),
      // body: ImageBlendFilters(),
      // body: GradientMaskFilter(),
      body: Stack(
        children: [
          buildBody(),
          buildLoader(),
        ],
      ),
    );
  }

  OutlinedButton buildSaveButton(BuildContext context) {
    return OutlinedButton.icon(
      style: const ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          Colors.blue,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(color: Colors.blue),
        ),
      ),
      onPressed: () {
        context.read<ImageFilterBloc>().add(SaveImageEvent());
      },
      label: const Text("Save"),
      icon: const Icon(Icons.save),
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
      buildWhen: (previous, current) {
        return current is! LoadingState;
      },
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
