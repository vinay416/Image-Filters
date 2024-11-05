import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/color_filter/cubit/color_filter_cubit.dart';
import 'package:image_filters/modules/color_filter/image_color_filters_view.dart';
import 'package:image_filters/modules/gradient_filter/cubit/gradient_filter_cubit.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc_state.dart';
import 'package:image_filters/modules/ai_filter/view/ai_image_filter_view.dart';
import 'package:image_filters/modules/gradient_filter/gradient_image_filters_view.dart';

import '../../ai_filter/view/image_preview/cubit/ai_image_fit_cubit.dart';

class ImageFiltersView extends StatelessWidget {
  const ImageFiltersView({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocProvider(create: (_) => GradientFilterCubit()),
        BlocProvider(create: (_) => ColorFilterCubit()),
        // AI filter
        BlocProvider(create: (_) => TextHandlerCubit()),
        BlocProvider(create: (_) => RemoveBgCubit()),
        BlocProvider(create: (_) => AiImageFitCubit()),
      ],
      child: BlocBuilder<FilterTabBloc, FilterTabBlocState>(
        builder: (context, state) {
          final tab = state.tabBar;

          return AnimatedSwitcher(
            duration: Durations.extralong4,
            switchInCurve: Curves.fastOutSlowIn,
            child: buildChild(tab),
          );
        },
      ),
    );
  }

  Widget buildChild(FilterTabBar tab) {
    if (tab == FilterTabBar.ai) {
      return AiImageFilterView(imagePath: imagePath);
    }
    if (tab == FilterTabBar.gradients) {
      return GradientImageFiltersView(imagePath: imagePath);
    }
    return ImageColorFiltersView(imagePath: imagePath);
  }
}
