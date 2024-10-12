import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/filters/image_blend_filters.dart';
import 'package:image_filters/tabbar/home_filter_tab_bar.dart';
import 'package:image_filters/views/ai_image/ai_image_view.dart';
import 'package:image_filters/views/mask_filters/mask_filters.dart';

class ImageFiltersBuilder extends StatelessWidget {
  const ImageFiltersBuilder({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageFilterBloc>();

    return BlocSelector<ImageFilterBloc, ImageFilterBlocStates, FilterTabBar>(
      selector: (state) {
        return state is TabViewState ? state.tabBar : bloc.tabBar;
      },
      builder: (context, state) {
        if (state == FilterTabBar.ai) {
          return AiImageView(imagePath: imagePath);
        }
        if (state == FilterTabBar.gradients) {
          return GradientMaskFilter(imagePath: imagePath);
        }
        return ImageBlendFilters(imagePath: imagePath);
      },
    );
  }
}
