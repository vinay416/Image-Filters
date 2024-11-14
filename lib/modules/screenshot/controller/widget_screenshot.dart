import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_filters/core/overlay_loader_mixin.dart';
import 'package:image_filters/modules/screenshot/service/storage_permission_mixin.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';

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

class WidgetSSController with StoragePermissionMixin, OverlayLoaderMixin {
  WidgetSSController(this.imagePath);
  final screenshotKey = GlobalKey();
  final String imagePath;

  Future<File?> takeScreenShot() async {
    try {
      insertFullLoader();
      final boundary = screenshotKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      if (pngBytes == null) throw Exception("Image SS bytes null");

      final directoryPath = await _getDirectoryPath();
      if (directoryPath == null) {
        Fluttertoast.showToast(msg: "Stoarge Permission not allowed");
        throw Exception("Directory path $directoryPath");
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName =
          imagePath.split('/').last.substring(0, imagePath.indexOf('.'));
      final mimetype = imagePath.split('.').last;
      final customDir =
          "$directoryPath/Filters/${fileName}_$timestamp.$mimetype";
      final imgFile = File(customDir);
      if (!imgFile.existsSync()) {
        imgFile.createSync(recursive: true);
      }
      final file = await imgFile.writeAsBytes(pngBytes);
      log("File path ${file.path}");
      await Future.delayed(Durations.long2);
      removeFullLoader();
      return file;
    } catch (e) {
      removeFullLoader();
      log('screenshot failed $e');
      return null;
    }
  }

  Future<String?> _getDirectoryPath() async {
    String? directory;
    if (Platform.isIOS) {
      return (await getTemporaryDirectory()).path;
    }

    if (Platform.isAndroid) {
      final granted = await _getStoragePermission();
      if (!granted) return null;

      final path = await const MethodChannel("externalStorage")
          .invokeMethod('getExternalStorageDirectory');
      directory = path;
    }
    return directory;
  }

  Future<bool> _getStoragePermission() async {
    try {
      final status = await isStoragePermissionGranted();
      return status == PermissionStatus.granted;
    } catch (e) {
      log("_getStoragePermission $e");
      return false;
    }
  }
}
