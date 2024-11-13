import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/text_handler/cubit/text_handler_cubit_state.dart';

enum TextFontFamilies {
  none(""),
  monoton("Monoton"),
  orbitron("Orbitron"),
  rockSalt("RockSalt"),
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

class TextFontFamiliesTools extends StatelessWidget {
  const TextFontFamiliesTools({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TextHandlerCubit>();
    return BlocBuilder<TextHandlerCubit, TextHandlerCubitState>(
      builder: (context, value) {
        const fontFamilies = TextFontFamilies.values;
        final selected = value.textModel.textStyle.fontFamily ?? "";

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          scrollDirection: Axis.horizontal,
          itemCount: fontFamilies.length,
          itemBuilder: (context, index) {
            final itemFamily = fontFamilies[index].fontFamily;
            final isSelected = itemFamily == selected;

            return InkWell(
              onTap: () => cubit.updateTextFamily(itemFamily),
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
