import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/pick_image/bloc/pick_image_bloc.dart';
import 'package:image_filters/modules/pick_image/view/widget/image_pick_bottem_sheet.dart';
import 'package:image_filters/modules/image_filters_tab/tabbar/image_filter_tab_bar.dart';
import 'package:image_filters/modules/image_filters_tab/view/image_filters_view.dart';
import 'package:image_filters/modules/pick_image/view/image_pick_empty_view.dart';
import 'package:image_filters/modules/pick_image/view/permission_error_view.dart';

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
      body: buildBody(),
    );
  }

  Widget buildRestAction() {
    return BlocSelector<PickImageBloc, PickImageBlocState, bool>(
      selector: (state) {
        if (state is PickImageResultState) return true;
        return false;
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

  Widget buildBody() {
    return BlocBuilder<PickImageBloc, PickImageBlocState>(
      builder: (context, state) {
        if (state is PickImagePermissionError) {
          return const PermissionErrorView();
        }
        if (state is PickImageResultState) {
          return Column(
            children: [
              const SizedBox(height: 30),
              const ImageFilterTabBar(),
              const SizedBox(height: 20),
              Expanded(
                child: ImageFiltersView(imagePath: state.imagePath),
              ),
            ],
          );
        }
        return const ImagePickEmptyView();
      },
    );
  }
}
