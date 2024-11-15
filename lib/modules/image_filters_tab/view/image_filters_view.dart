import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/color_filter/image_color_filters_view.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc_state.dart';
import 'package:image_filters/modules/ai_filter/view/ai_image_filter_view.dart';
import 'package:image_filters/modules/gradient_filter/gradient_image_filters_view.dart';
import 'package:image_filters/modules/pick_image/model/image_pick_model.dart';

class ImageFiltersView extends StatefulWidget {
  const ImageFiltersView({super.key, required this.image});
  final ImagePickModel image;

  @override
  State<ImageFiltersView> createState() => _ImageFiltersViewState();
}

class _ImageFiltersViewState extends State<ImageFiltersView> {
  @override
  void initState() {
    super.initState();
    context.read<RemoveBgCubit>().reset();
    context.read<TextHandlerCubit>().resetTextForeground();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterTabBloc, FilterTabBlocState>(
      builder: (context, state) {
        final tab = state.tabBar;

        return AnimatedSwitcher(
          duration: Durations.extralong4,
          switchInCurve: Curves.fastOutSlowIn,
          child: buildChild(tab),
        );
      },
    );
  }

  Widget buildChild(FilterTabBar tab) {
    if (tab == FilterTabBar.ai) {
      return AiImageFilterView(image: widget.image);
    }
    if (tab == FilterTabBar.gradients) {
      return GradientImageFiltersView(image: widget.image);
    }
    return ImageColorFiltersView(image: widget.image);
  }
}
