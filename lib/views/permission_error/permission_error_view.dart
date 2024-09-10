import 'package:flutter/material.dart';
import 'package:image_filters/core/image_camera_permission_mixin.dart';

class PermissionErrorView extends StatelessWidget {
  const PermissionErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          const Text(
            "No Permission, please allow to continue",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              ImageCameraPermissionMixin.openPermissionSettings();
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.blue),
            ),
            child: const Text(
              "Open settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
