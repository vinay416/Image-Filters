import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

mixin StoragePermissionMixin {
  Future<PermissionStatus> isStoragePermissionGranted() async {
    try {
      Permission permission = Permission.manageExternalStorage;

      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) permission = Permission.storage;

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
}
