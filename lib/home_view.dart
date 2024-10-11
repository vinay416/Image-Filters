import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/tabbar/home_filter_tab_bar.dart';
import 'package:image_filters/views/image_filters_builder/image_filters_builder.dart';
import 'package:image_filters/views/image_pick_view/image_pick_view.dart';
import 'package:image_filters/views/permission_error/permission_error_view.dart';
import 'package:image_filters/views/widget/image_pick_bottem_sheet.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Filters",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        actions: [
          buildRestAction(),
          const SizedBox(width: 10),
        ],
      ),
      body: Stack(
        children: [
          buildBody(),
          buildLoader(),
        ],
      ),
    );
  }

  Widget buildRestAction() {
    return BlocSelector<ImageFilterBloc, ImageFilterBlocStates, bool>(
      selector: (state) {
        if (state is LoadingState) return !state.loading;
        return (state is ImageFiltersState) || (state is TabViewState);
      },
      builder: (context, state) {
        if (!state) return const SizedBox.shrink();
        return IconButton(
          onPressed: () => ImagePickBottemSheet.show(context),
          icon: const Icon(
            Icons.add_a_photo_outlined,
            color: Colors.blue,
            size: 30,
          ),
        );
      },
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
        return current is! LoadingState && current is! TabViewState;
      },
      builder: (context, state) {
        if (state is PermissionErrorState) {
          return const PermissionErrorView();
        }
        if (state is ImageFiltersState) {
          return Column(
            children: [
              const SizedBox(height: 30),
              const HomeFilterTabBar(),
              const SizedBox(height: 20),
              Expanded(
                child: ImageFiltersBuilder(imagePath: state.path),
              ),
            ],
          );
        }
        return const ImagePickView();
      },
    );
  }
}
