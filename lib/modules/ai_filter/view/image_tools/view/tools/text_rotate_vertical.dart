import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/slider/slider_widget.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'dart:math' as math;

class TextRotateVerticalTool extends StatelessWidget {
  const TextRotateVerticalTool({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        final dy = value.textModel.rotate.dy;
        return SliderWidget(
          min: -(math.pi / 2.5),
          max: (math.pi / 2.5),
          selectedValue: dy,
          onChange: context.read<TextHandlerCubit>().updateRotationY,
        );
      },
    );
  }
}
