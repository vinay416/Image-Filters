import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/common/custom_circurlar_button.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/cubit/image_tools_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_color_tool.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/image_bg_depth_tool.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_depth_button.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_font_families_tools.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_rotate_horizontal.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_rotate_vertical.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/tools/text_size_tool.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';

class TextToolsView extends StatefulWidget {
  const TextToolsView({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<TextToolsView> createState() => _TextToolsViewState();
}

class _TextToolsViewState extends State<TextToolsView> {
  late String imagePath;
  final scrollController = ScrollController();

  @override
  void initState() {
    imagePath = widget.imagePath;
    super.initState();
    context
        .read<TextHandlerCubit>()
        .setToolsListScrollController(scrollController);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: buildTool(context),
        ),
        SizedBox(
          height: 65,
          child: ListView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              buildButton(option: ImageToolsEnum.textSize),
              buildButton(option: ImageToolsEnum.fontFamily),
              buildButton(option: ImageToolsEnum.textColor),
              buildButton(option: ImageToolsEnum.rotateX),
              buildButton(option: ImageToolsEnum.rotateY),
              TextDepthButton(
                imagePath: widget.imagePath,
                scrollController: scrollController,
              ),
              buildButton(option: ImageToolsEnum.depthEffect)
            ],
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required ImageToolsEnum option,
  }) {
    return BlocBuilder<ImageToolsCubit, ImageToolsEnum>(
      builder: (context, selected) {
        final isSelected = selected == option;
        return CustomCircularButton(
          extentLabel: option.label,
          isExtent: isSelected,
          onTap: () => context.read<ImageToolsCubit>().onTap(option),
          icon: option.icon,
          bgColor: isSelected ? Colors.blue : Colors.black,
        );
      },
    );
  }

  Widget buildTool(BuildContext context) {
    return BlocBuilder<ImageToolsCubit, ImageToolsEnum>(
      builder: (context, selected) {
        Widget tool = const SizedBox.shrink();
        switch (selected) {
          case ImageToolsEnum.textSize:
            tool = const TextSizeTool();
            break;
          case ImageToolsEnum.fontFamily:
            tool = const TextFontFamiliesTools();
            break;
          case ImageToolsEnum.textColor:
            tool = const TextColorTool();
            break;
          case ImageToolsEnum.rotateX:
            tool = const TextRotateHorizontalTool();
            break;
          case ImageToolsEnum.rotateY:
            tool = const TextRotateVerticalTool();
            break;
          case ImageToolsEnum.depthEffect:
            tool = const ImageBgDepthTool();
            break;
        }
        return tool;
      },
    );
  }
}
