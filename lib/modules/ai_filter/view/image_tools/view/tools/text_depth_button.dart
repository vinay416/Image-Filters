import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/common/custom_circurlar_button.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';

class TextDepthButton extends StatelessWidget {
  const TextDepthButton({
    super.key,
    required this.imagePath,
    required this.scrollController,
  });
  final String imagePath;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        final bool isForegroundText = value.textModel.isForegroundText;
        return CustomCircularButton(
          onTap: () => onTap(context),
          icon: CupertinoIcons.view_3d,
          bgColor: isForegroundText ? Colors.black : Colors.orange,
        );
      },
    );
  }

  void onTap(BuildContext context) async {
    final removeBgCubit = context.read<RemoveBgCubit>();
    final isAlreadyRemoved = removeBgCubit.state.originalImage == imagePath;
    final textHandlerCubit = context.read<TextHandlerCubit>();
    if (!isAlreadyRemoved) {
      final isSuccess = await removeBgCubit.removeBg(imagePath);
      textHandlerCubit.toggleTextForeground(isSuccess);
    } else {
      textHandlerCubit.toggleTextForeground(isAlreadyRemoved);
    }
    animateScroll();
  }

  void animateScroll() async {
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Durations.medium2,
      curve: Curves.decelerate,
    );
  }
}
