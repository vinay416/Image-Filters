import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/modules/ai_filter/view/image_super_impose/cubit/remove_bg_cubit.dart';
import 'package:image_filters/modules/ai_filter/view/image_tools/view/text_tools_view.dart';
import 'package:image_filters/modules/screenshot/controller/widget_screenshot.dart';
import 'image_preview/view/ai_image_preview.dart';

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
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AiImagePreview(
              imageFile: imageFile,
              ssController: ssController,
            ),
            const SizedBox(height: 20),
            TextToolsView(),
            // buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return OutlinedButton.icon(
      onPressed: () {
        context.read<RemoveBgCubit>().removeBg(widget.imagePath);
      },
      style: const ButtonStyle(
        side: WidgetStatePropertyAll(
          BorderSide(
            color: Colors.deepPurple,
            width: 2,
          ),
        ),
      ),
      label: const Text(
        "Reimagine*",
        style: TextStyle(fontSize: 20),
      ),
      icon: const Icon(Icons.mms_outlined),
      iconAlignment: IconAlignment.end,
    );
  }
}
