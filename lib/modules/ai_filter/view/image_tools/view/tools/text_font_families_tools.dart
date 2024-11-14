import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

enum TextFontFamilies {
  none(""),
  monoton("Monoton"),
  rockSalt("RockSalt"),
  orbitron("Orbitron"),
  sourGummy("SourGummy"),
  basasNeue("BebasNeue"),
  anton("Anton"),
  pacifico("Pacifico"),
  dancingScript("DancingScript"),
  shadowsIntoLight("ShadowsIntoLight"),
  doto("Doto"),
  caveat("Caveat"),
  ;

  final String? fontFamily;
  const TextFontFamilies(this.fontFamily);
}

class TextFontFamiliesTools extends StatefulWidget {
  const TextFontFamiliesTools({super.key});

  @override
  State<TextFontFamiliesTools> createState() => _TextFontFamiliesToolsState();
}

class _TextFontFamiliesToolsState extends State<TextFontFamiliesTools> {
  final AutoScrollController controller = AutoScrollController();
  late TextHandlerCubit textHandlerCubit;

  @override
  void initState() {
    super.initState();
    textHandlerCubit = context.read<TextHandlerCubit>();
  }

  @override
  void didChangeDependencies() {
    final current = textHandlerCubit.state.textModel.textStyle.fontFamily;
    final index =
        TextFontFamilies.values.indexWhere((e) => e.fontFamily == current);
    if (index == -1) return;
    controller.scrollToIndex(
      index,
      duration: const Duration(milliseconds: 200),
      preferPosition: AutoScrollPosition.middle,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        const fontFamilies = TextFontFamilies.values;
        final selected = value.textModel.textStyle.fontFamily ?? "";

        return ListView.separated(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          scrollDirection: Axis.horizontal,
          itemCount: fontFamilies.length,
          itemBuilder: (context, index) {
            final itemFamily = fontFamilies[index].fontFamily;
            final isSelected = itemFamily == selected;

            return AutoScrollTag(
              controller: controller,
              index: index,
              key: ValueKey(index),
              child: InkWell(
                onTap: () => textHandlerCubit.updateTextFamily(itemFamily),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected ? Colors.black54 : null,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  child: Text(
                    "Awesome",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: itemFamily,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
        );
      },
    );
  }
}
