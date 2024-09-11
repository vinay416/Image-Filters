import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';
import 'package:image_filters/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageFilterBloc(),
      child: const MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
