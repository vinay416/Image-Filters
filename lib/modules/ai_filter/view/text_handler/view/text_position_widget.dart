import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/model/ai_image_text_model.dart';

class TextPositionWidget extends StatefulWidget {
  const TextPositionWidget({super.key});

  @override
  State<TextPositionWidget> createState() => _TextPositionWidgetState();
}

class _TextPositionWidgetState extends State<TextPositionWidget> {
  late TextHandlerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TextHandlerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, state) {
        final pos = state.textModel.position;
        final rotate = state.textModel.rotate;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(pos.dx, pos.dy)
            ..rotateX(rotate.dx)
            ..rotateY(rotate.dy),
          alignment: Alignment.center,
          child: buildText(state.textModel),
        );
      },
    );
  }

  Widget buildText(AiImageTextModel textModel) {
    final bool isFieldFocused = textModel.isFieldFocused;

    return Text(
      textModel.text,
      style: textModel.textStyle.copyWith(
        color: isFieldFocused ? Colors.transparent : null,
      ),
      textAlign: TextAlign.center,
    );
  }
}
