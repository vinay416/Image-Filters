import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'package:image_filters/modules/color_filter/widget/image_color_filters.dart';

class TextColorTool extends StatefulWidget {
  const TextColorTool({super.key});

  @override
  State<TextColorTool> createState() => _TextColorToolState();
}

class _TextColorToolState extends State<TextColorTool> {
  final List<Color> colors = [
    Colors.white,
    Colors.black,
    ...Colors.primaries,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        return ColorFilterPicker(
          size: 40,
          colors: colors,
          selectedColor: value.textModel.textStyle.color,
          onColorChanged: context.read<TextHandlerCubit>().updateTextColor,
        );
      },
    );
  }
}
