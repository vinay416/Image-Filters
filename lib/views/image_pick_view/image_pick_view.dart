import 'package:flutter/material.dart';
import 'package:image_filters/views/widget/image_pick_bottem_sheet.dart';

class ImagePickView extends StatelessWidget {
  const ImagePickView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/empty_state.png",
          ),
          buildText(),
          const SizedBox(height: 20),
          buildButton(
            onTap: () => ImagePickBottemSheet.show(context),
            text: "Pick image",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildButton({
    required VoidCallback onTap,
    required String text,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  Text buildText() {
    return const Text(
      "Pick your image from Gallery or Camera.",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}
