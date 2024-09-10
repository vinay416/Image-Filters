import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';

class ImagePickView extends StatelessWidget {
  const ImagePickView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: DottedBorder(
        strokeWidth: 2,
        color: Colors.grey,
        dashPattern: const [10, 3],
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        padding: const EdgeInsets.all(20),
        child: buildChild(context),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    final bloc = context.read<ImageFilterBloc>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildAsset(),
          buildText(),
          const SizedBox(height: 20),
          buildButton(
            onTap: () => bloc.add(PickFromCameraEvent()),
            text: "Camera",
          ),
          const SizedBox(height: 20),
          buildButton(
            onTap: () => bloc.add(PickFromGalleryEvent()),
            text: "Gallery",
          ),
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
      "Pick your image from Camera or Gallery.",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }

  Stack buildAsset() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Icon(
          Icons.image_rounded,
          color: Colors.blue.shade400,
          size: 150,
        ),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(
            Icons.add_rounded,
            size: 40,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
