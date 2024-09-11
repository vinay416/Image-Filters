import 'package:flutter/material.dart';

enum FilterTabBar{
  colors,
  gradients,
}

class HomeFilterTabBar extends StatefulWidget {
  const HomeFilterTabBar({super.key});

  @override
  State<HomeFilterTabBar> createState() => _HomeFilterTabBarState();
}

class _HomeFilterTabBarState extends State<HomeFilterTabBar> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}