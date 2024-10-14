import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

mixin ImageCameraPermissionMixin {
  Future<PermissionStatus> isImagePermissionGranted() async {
    try {
      Permission permission = Permission.photos;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt < 33) permission = Permission.storage;
      }

      final status = await permission.status;
      if (status == PermissionStatus.permanentlyDenied) {
        return PermissionStatus.permanentlyDenied;
      }
      if (status == PermissionStatus.denied) {
        final requestStatus = await permission.request();
        return requestStatus;
      }
      return PermissionStatus.granted;
    } catch (e) {
      log("Error --> permission $e");
      return PermissionStatus.permanentlyDenied;
    }
  }

  Future<PermissionStatus> isCameraPermissionGranted() async {
    try {
      Permission permission = Permission.camera;

      final status = await permission.status;
      if (status == PermissionStatus.permanentlyDenied) {
        return PermissionStatus.permanentlyDenied;
      }
      if (status == PermissionStatus.denied) {
        final requestStatus = await permission.request();
        return requestStatus;
      }
      return PermissionStatus.granted;
    } catch (e) {
      log("Error --> permission $e");
      return PermissionStatus.permanentlyDenied;
    }
  }

  static void openPermissionSettings() {
    openAppSettings();
  }
}
