import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/gradient_filter/cubit/gradient_filter_cubit.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc.dart';
import 'package:image_filters/modules/pick_image/bloc/pick_image_bloc.dart';
import 'package:image_filters/modules/pick_image/view/widget/image_pick_bottem_sheet.dart';
import 'package:image_filters/modules/image_filters_tab/tabbar/image_filter_tab_bar.dart';
import 'package:image_filters/modules/image_filters_tab/view/image_filters_view.dart';
import 'package:image_filters/modules/pick_image/view/image_pick_empty_view.dart';
import 'package:image_filters/modules/pick_image/view/permission_error_view.dart';

import '../ai_filter/view/image_preview/cubit/ai_image_fit_cubit.dart';
import '../ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import '../ai_filter/view/image_tools/cubit/image_tools_cubit.dart';
import '../ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import '../color_filter/cubit/color_filter_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filters",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade800,
          ),
        ),
        centerTitle: false,
        actions: [
          buildResetFilterAction(),
          const SizedBox(width: 10),
          buildImagePickAction(),
          const SizedBox(width: 10),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildImagePickAction() {
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

  Widget buildResetFilterAction() {
    return BlocSelector<PickImageBloc, PickImageBlocState, bool>(
      selector: (state) {
        if (state is PickImageResultState) return true;
        return false;
      },
      builder: (context, picked) {
        if (!picked) return const SizedBox.shrink();
        return SizedBox(
          height: 35,
          child: TextButton(
            onPressed: () {
              final tab = context.read<FilterTabBloc>().state.tabBar;
              switch (tab) {
                case FilterTabBar.colors:
                  context.read<ColorFilterCubit>().resetState();
                  break;
                case FilterTabBar.gradients:
                  context.read<GradientFilterCubit>().resetState();
                  break;
                case FilterTabBar.ai:
                  context.read<RemoveBgCubit>().reset();
                  context.read<AiImageFitCubit>().reset();
                  context.read<TextHandlerCubit>().resetState();
                  context.read<ImageToolsCubit>().reset();
                  break;
                default:
              }
            },
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
              foregroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            child: const Text(
              "Reset",
              style: TextStyle(fontSize: 18),
            ),
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
            key: ObjectKey(state.image),
            children: [
              const SizedBox(height: 5),
              const ImageFilterTabBar(),
              const SizedBox(height: 20),
              Expanded(
                child: ImageFiltersView(image: state.image),
              ),
            ],
          );
        }
        return const ImagePickEmptyView();
      },
    );
  }
}
