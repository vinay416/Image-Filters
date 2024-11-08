import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/home/home_view.dart';
import 'package:image_filters/modules/pick_image/bloc/pick_image_bloc.dart';

import 'modules/ai_filter/view/image_preview/cubit/ai_image_fit_cubit.dart';
import 'modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'modules/ai_filter/view/image_tools/cubit/image_tools_cubit.dart';
import 'modules/ai_filter/view/text_handler/cubit/text_handler_cubit.dart';
import 'modules/color_filter/cubit/color_filter_cubit.dart';
import 'modules/gradient_filter/cubit/gradient_filter_cubit.dart';
import 'modules/image_filters_tab/bloc/filter_tab_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PickImageBloc()),
        BlocProvider(create: (_) => FilterTabBloc()),
        BlocProvider(create: (_) => GradientFilterCubit()),
        BlocProvider(create: (_) => ColorFilterCubit()),
        // AI filter
        BlocProvider(create: (_) => TextHandlerCubit()),
        BlocProvider(create: (_) => RemoveBgCubit()),
        BlocProvider(create: (_) => AiImageFitCubit()),
        BlocProvider(create: (_) => ImageToolsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
        ),
        home: const HomeView(),
      ),
    );
  }
}
