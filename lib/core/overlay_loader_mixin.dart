import 'package:flutter/material.dart';
import 'package:image_filters/main.dart';
import 'package:loading_animations/loading_animations.dart';

mixin OverlayLoaderMixin {
  late OverlayEntry _overlayEntry;

  void insertFullLoader() {
    final OverlayState? overlay = MainApp.navigatorKey.currentState?.overlay;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black54,
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );

    overlay?.insert(_overlayEntry);
  }

  void removeFullLoader() => _overlayEntry.remove();
}
