import 'package:flutter/material.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.controller});
  final WidgetSSController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
            Colors.white,
          ),
          backgroundColor: WidgetStatePropertyAll(Colors.black26),
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.blue),
          ),
        ),
        onPressed: () {
          controller.takeScreenShot();
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
