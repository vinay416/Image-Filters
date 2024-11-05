import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_preview/cubit/ai_image_fit_cubit.dart';

class AiImageFitIconButton extends StatelessWidget {
  const AiImageFitIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiImageFitCubit, BoxFit>(
      builder: (context, fit) {
        final bool isCover = fit == BoxFit.cover;
        return Padding(
          padding: const EdgeInsets.all(4),
          child: InkWell(
            onTap: () {
              context.read<AiImageFitCubit>().toggleFit();
            },
            borderRadius: BorderRadius.circular(5),
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: Icon(
                isCover
                    ? Icons.fullscreen_exit_rounded
                    : Icons.fullscreen_rounded,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
