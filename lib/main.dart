import 'package:flutter/material.dart';

import 'filters/image_blend_filters.dart';
import 'filters/mask_filters.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // body: ImageBlendFilters(),
        body: MaskFilters(),
      ),
    );
  }
}
