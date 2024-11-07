import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/pick_image/bloc/pick_image_bloc.dart';

class ImagePickBottemSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ImagePickBottemSheetWidget(),
    );
  }
}

class ImagePickBottemSheetWidget extends StatelessWidget {
  const ImagePickBottemSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PickImageBloc>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            "Pick image",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    bloc.add(PickImageFromGallery());
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Icon(Icons.photo),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                  color: Colors.green,
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    bloc.add(PickImageFromCamera());
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Icon(Icons.photo_camera),
                        Text("Camera"),
                      ],
                    ),
                  ),
                  color: Colors.blue,
                  iconSize: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
