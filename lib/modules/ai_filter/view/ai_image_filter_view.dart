import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_filters/modules/ai_filter/services/ai_image_api_services.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';

import 'image_preview/ai_image_preview.dart';

class AiImageFilterView extends StatefulWidget {
  const AiImageFilterView({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<AiImageFilterView> createState() => _AiImageFilterViewState();
}

class _AiImageFilterViewState extends State<AiImageFilterView> {
  late FileImage imageFile;
  late WidgetSSController ssController;

  @override
  void initState() {
    ssController = WidgetSSController(widget.imagePath);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precache();
    super.didChangeDependencies();
  }

  void precache() {
    imageFile = FileImage(File(widget.imagePath));
    precacheImage(imageFile, context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AiImagePreview(
            imageFile: imageFile,
            ssController: ssController,
          ),
          const Divider(
            thickness: 5,
          ),
          BGIMage(imagePath: widget.imagePath),
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
