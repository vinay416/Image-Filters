import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/common/custom_circurlar_button.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/cubit/image_tools_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_rotate_horizontal.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_rotate_vertical.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_size_tool.dart';

class TextToolsView extends StatelessWidget {
  const TextToolsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTool(),
        Wrap(
          children: [
            buildButton(option: ImageToolsEnum.textSize),
            buildButton(option: ImageToolsEnum.fontFamily),
            buildButton(option: ImageToolsEnum.textColor),
            buildButton(option: ImageToolsEnum.rotateX),
            buildButton(option: ImageToolsEnum.rotateY),
            buildButton(option: ImageToolsEnum.depthEffect),
          ],
        ),
      ],
    );
  }

  Widget buildButton({required ImageToolsEnum option}) {
    return BlocBuilder<ImageToolsCubit, ImageToolsEnum>(
      builder: (context, selected) {
        final isSelected = selected == option;
        return CustomCircularButton(
          onTap: () => context.read<ImageToolsCubit>().onTap(option),
          icon: option.icon,
          bgColor: isSelected ? Colors.blue : Colors.black,
        );
      },
    );
  }

  Widget buildTool() {
    return BlocBuilder<ImageToolsCubit, ImageToolsEnum>(
      builder: (context, selected) {
        Widget tool = const TextSizeTool();
        switch (selected) {
          case ImageToolsEnum.textSize:
            tool = const TextSizeTool();
            break;
          case ImageToolsEnum.fontFamily:
            break;
          case ImageToolsEnum.textColor:
            break;
          case ImageToolsEnum.rotateX:
            tool = const TextRotateHorizontalTool();
            break;
          case ImageToolsEnum.rotateY:
            tool = const TextRotateVerticalTool();
            break;
          case ImageToolsEnum.depthEffect:
            break;
        }
        return tool;
      },
    );
  }
}
