import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/slider/slider_widget.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';

class TextSizeTool extends StatelessWidget {
  const TextSizeTool({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        final size = value.textModel.textStyle.fontSize ?? 50;
        return SliderWidget(
          min: 20,
          max: 400,
          selectedValue: size,
          onChange: context.read<TextHandlerCubit>().updateTextSize,
        );
      },
    );
  }
}
