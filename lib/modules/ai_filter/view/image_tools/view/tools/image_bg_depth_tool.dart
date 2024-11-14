import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/slider/slider_widget.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';

class ImageBgDepthTool extends StatelessWidget {
  const ImageBgDepthTool({super.key});

  @override
  Widget build(BuildContext context) {
    final textHandleCubit = context.read<TextHandlerCubit>();

    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, state) {
        final is2D = state.textModel.isForegroundText;

        if (is2D) {
          return const Text(
            "Tap on 3D to Enable this feature",
            style: TextStyle(fontSize: 20),
          );
        }

        final blurValue = state.textModel.backgroundBlur;
        return SliderWidget(
          selectedValue: blurValue,
          min: 0,
          max: 50,
          onChange: textHandleCubit.updateBackgroundBlur,
        );
      },
    );
  }
}
