import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_tab_bloc_event.dart';
import 'filter_tab_bloc_state.dart';

enum FilterTabBar {
  colors("Color Filters"),
  gradients("Gradient Filters"),
  ai("AI");

  final String title;
  const FilterTabBar(this.title);
}

class FilterTabBloc extends Bloc<FilterTabBlocEvent, FilterTabBlocState> {
  FilterTabBloc() : super(FilterTabBlocState(FilterTabBar.colors)) {
    on<FilterTabBlocEvent>(
      (event, emit) {
        emit(FilterTabBlocState(event.tabBar));
      },
    );
  }
}
