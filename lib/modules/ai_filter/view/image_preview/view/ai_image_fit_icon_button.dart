import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/common/custom_circurlar_button.dart';
import 'package:image_filters/modules/ai_filter/view/image_preview/cubit/ai_image_fit_cubit.dart';

class AiImageFitIconButton extends StatelessWidget {
  const AiImageFitIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiImageFitCubit, BoxFit>(
      builder: (context, fit) {
        final bool isCover = fit == BoxFit.cover;
        return CustomCircularButton(
          onTap: context.read<AiImageFitCubit>().toggleFit,
          icon: isCover
              ? Icons.fullscreen_exit_rounded
              : Icons.fullscreen_rounded,
          bgColor: Colors.black26,
        );
      },
    );
  }
}
