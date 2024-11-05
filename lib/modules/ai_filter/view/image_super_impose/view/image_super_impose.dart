import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit_state.dart';

class ImageSuperImpose extends StatelessWidget {
  const ImageSuperImpose({super.key, required this.fit});
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoveBgCubit, RemoveBgCubitState>(
      builder: (context, state) {
        final imageBytes = state.removedBgImage;

        if (imageBytes == null) return const SizedBox.shrink();
        return Image.memory(
          imageBytes,
          fit: fit,
        );
      },
    );
  }
}
