import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class WidgetScreenshot extends StatelessWidget {
  const WidgetScreenshot({
    super.key,
    required this.child,
    required this.controller,
  });
  final Widget child;
  final WidgetSSController? controller;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller?.screenshotKey,
      child: child,
    );
  }
}

class WidgetSSController {
  final screenshotKey = GlobalKey();

  Future<File?> takeScreenShot() async {
    try {
      final boundary = screenshotKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      if (pngBytes == null) throw Exception("Image SS bytes null");

      final directoryPath = await _getDirectoryPath();
      if (directoryPath == null) throw Exception("Directory path $directoryPath");

      final imgFile =
          File('$directoryPath/screenshot${DateTime.now().millisecond}.png');
      final file = await imgFile.writeAsBytes(pngBytes);
      log("File path ${file.path}");
      return file;
    } catch (e) {
      log('screenshot failed $e');
      return null;
    }
  }

  Future<String?> _getDirectoryPath() async {
    String? directory;
    if (Platform.isIOS) {
      directory = (await getTemporaryDirectory()).path;
    } else if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!.path;
    }
    return directory;
  }
}
