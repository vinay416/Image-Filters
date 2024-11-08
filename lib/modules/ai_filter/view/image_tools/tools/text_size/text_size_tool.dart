import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';

class TextSizeTool extends StatelessWidget {
  const TextSizeTool({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        final size = value.textModel.textStyle.fontSize ?? 50;
        return SliderTheme(
          data: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorShape: DropSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.black,
            valueIndicatorStrokeColor: Colors.blue,
            valueIndicatorTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            activeTrackColor: Colors.blue,
            thumbColor: Colors.black,
          ),
          child: Slider.adaptive(
            onChanged: context.read<TextHandlerCubit>().updateTextSize,
            label: "${size.toInt()}",
            min: 20,
            max: 400,
            value: size,
          ),
        );
      },
    );
  }
}
