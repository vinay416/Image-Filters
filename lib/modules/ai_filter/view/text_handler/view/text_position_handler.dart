import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/model/ai_image_text_model.dart';

class TextPositionHandler extends StatefulWidget {
  const TextPositionHandler({super.key});

  @override
  State<TextPositionHandler> createState() => _TextPositionHandlerState();
}

class _TextPositionHandlerState extends State<TextPositionHandler> {
  late TextHandlerCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TextHandlerCubit>();
  }

  void onPointerMove(PointerMoveEvent event) {
    final pos = event.localPosition;
    cubit.updatePosition(pos);
  }

  void onPointerDown(PointerDownEvent event) {
    cubit.isEditing(true);
  }

  void onPointerUp(PointerUpEvent event) {
    cubit.isEditing(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, state) {
        final pos = state.textModel.position;
        return Transform(
          transform: Matrix4.identity()..translate(pos.dx, pos.dy),
          alignment: Alignment.center,
          child: Listener(
            onPointerDown: onPointerDown,
            onPointerUp: onPointerUp,
            onPointerMove: onPointerMove,
            child: buildText(state.textModel),
          ),
        );
      },
    );
  }

  Widget buildText(AiImageTextModel textModel) {
    final size = textSizeArea(textModel);
    final bool isEditing = textModel.isEditing;
    return Container(
      decoration: BoxDecoration(
        border: isEditing
            ? Border.all(
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: size.height,
        width: size.width,
      ),
    );
  }

  Size textSizeArea(AiImageTextModel textModel) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: "EMMA",
          style: TextStyle(
            color: Colors.white,
            fontSize: 120,
          )),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
