import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc_event.dart';
import 'package:image_filters/modules/image_filters_tab/bloc/filter_tab_bloc_state.dart';

import '../bloc/filter_tab_bloc.dart';

class ImageFilterTabBar extends StatefulWidget {
  const ImageFilterTabBar({super.key});

  @override
  State<ImageFilterTabBar> createState() => _ImageFilterTabBarState();
}

class _ImageFilterTabBarState extends State<ImageFilterTabBar> {
  late FilterTabBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<FilterTabBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(5),
      child: BlocBuilder<FilterTabBloc, FilterTabBlocState>(
        builder: (context, state) {
          final tab = state.tabBar;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildButton(
                title: FilterTabBar.colors,
                selected: tab,
              ),
              const SizedBox(width: 5),
              buildButton(
                title: FilterTabBar.gradients,
                selected: tab,
              ),
              const SizedBox(width: 5),
              buildButton(
                title: FilterTabBar.ai,
                selected: tab,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildButton({
    required FilterTabBar title,
    required FilterTabBar selected,
  }) {
    final bool isSelected = title == selected;
    return GestureDetector(
      onTap: () {
        selected = title;
        context.read<FilterTabBloc>().add(FilterTabBlocEvent(title));
      },
      child: Material(
        shape: const StadiumBorder(),
        elevation: isSelected ? 5 : 0,
        child: Container(
          constraints: const BoxConstraints(minWidth: 50),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : null,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          alignment: Alignment.center,
          child: Text(
            title.title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
