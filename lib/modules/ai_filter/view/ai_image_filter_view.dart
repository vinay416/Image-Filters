import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_filters/modules/ai_filter/services/ai_image_api_services.dart';

class AiImageFilterView extends StatelessWidget {
  const AiImageFilterView({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.file(File(imagePath)),
          const Divider(
            thickness: 5,
          ),
          BGIMage(imagePath: imagePath),
        ],
      ),
    );
  }
}

class BGIMage extends StatefulWidget {
  const BGIMage({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<BGIMage> createState() => _BGIMageState();
}

class _BGIMageState extends State<BGIMage> {
  bool isDone = false;
  late Uint8List bodyBytes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isDone
            ? Image.memory(bodyBytes)
            : ElevatedButton(
                onPressed: () async {
                  log("removing......");
                  final response = await AiImageApiServices().removeBgApi(
                    widget.imagePath,
                  );
                  log("removed");
                  bodyBytes = response;
                  isDone = true;
                  setState(() {});
                },
                child: const Text("Remove BG"),
              ),
        ElevatedButton(
          onPressed: () {
            isDone = false;
            setState(() {});
          },
          child: const Text("Reset"),
        ),
        const Divider(
          thickness: 5,
        ),
        if (isDone)
          Stack(
            alignment: Alignment.center,
            children: [
              Image.file(File(widget.imagePath)),
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(),
                  ),
                ),
              ),
              const Positioned(
                top: 90,
                child: Text(
                  "HI, babe",
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
              Image.memory(bodyBytes)
            ],
          )
      ],
    );
  }
}
