import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit_state.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';

class ImageSuperImpose extends StatelessWidget {
  const ImageSuperImpose({super.key, required this.fit});
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final is2D = context.select<TextHandlerCubit, bool>(
        (value) => value.state.textModel.isForegroundText);
    return BlocBuilder<RemoveBgCubit, RemoveBgCubitState>(
      builder: (context, state) {
        final imageBytes = state.removedBgImage;

        if (imageBytes == null || is2D) return const SizedBox.shrink();
        return Image.memory(
          imageBytes,
          fit: fit,
        );
      },
    );
  }
}
