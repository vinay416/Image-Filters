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
        final rotate = state.textModel.rotate;
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(pos.dx, pos.dy)
            ..rotateX(rotate.dx)
            ..rotateY(rotate.dy),
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
    final bool isFieldFocused = textModel.isFieldFocused;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isFieldFocused ? Colors.black54 : null,
        border: isEditing ? Border.all(width: 2) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: size.width + 20,
        child: buildTextField(textModel),
      ),
    );
  }

  Widget buildTextField(AiImageTextModel textModel) {
    InputBorder buildBorder() {
      return InputBorder.none;
    }

    final bool isFieldFocused = textModel.isFieldFocused;

    return TextFormField(
      initialValue: textModel.text,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      style: textModel.textStyle.copyWith(
        color: isFieldFocused ? null : Colors.transparent,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
        cubit.isFieldFocused(false);
      },
      onTap: () => cubit.isFieldFocused(true),
      magnifierConfiguration: TextMagnifierConfiguration.disabled,
      onChanged: cubit.onChangeText,
      cursorColor: textModel.textStyle.color,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: buildBorder(),
        focusedBorder: buildBorder(),
        enabledBorder: buildBorder(),
        isCollapsed: true,
      ),
    );
  }

  Size textSizeArea(AiImageTextModel textModel) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: textModel.text,
        style: textModel.textStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
