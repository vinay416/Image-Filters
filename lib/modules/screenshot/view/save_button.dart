import 'package:flutter/material.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.controller});
  final WidgetSSController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: OutlinedButton.icon(
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
            Colors.white,
          ),
          backgroundColor: WidgetStatePropertyAll(Colors.black26),
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.grey),
          ),
        ),
        onPressed: () {
          controller.takeScreenShot();
        },
        label: const Text(
          "Save",
          style: TextStyle(fontSize: 18),
        ),
        icon: const Icon(Icons.download),
      ),
    );
  }
}
