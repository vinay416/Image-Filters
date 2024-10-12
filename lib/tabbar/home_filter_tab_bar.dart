import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';

enum FilterTabBar {
  colors("Color Filters"),
  gradients("Gradient Filters"),
  ai("AI");

  final String title;
  const FilterTabBar(this.title);
}

class HomeFilterTabBar extends StatefulWidget {
  const HomeFilterTabBar({super.key});

  @override
  State<HomeFilterTabBar> createState() => _HomeFilterTabBarState();
}

class _HomeFilterTabBarState extends State<HomeFilterTabBar> {
  late ImageFilterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ImageFilterBloc>();
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
      child: BlocSelector<ImageFilterBloc, ImageFilterBlocStates, FilterTabBar>(
        selector: (state) {
          return (state is TabViewState) ? state.tabBar : bloc.tabBar;
        },
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildButton(
                title: FilterTabBar.colors,
                selected: state,
              ),
              const SizedBox(width: 5),
              buildButton(
                title: FilterTabBar.gradients,
                selected: state,
              ),
              const SizedBox(width: 5),
              buildButton(
                title: FilterTabBar.ai,
                selected: state,
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
        context.read<ImageFilterBloc>().add(TabbarEvent(title));
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
