import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_filters/core_bloc/image_filter_bloc.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton.icon(
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(
            Colors.white,
          ),
          backgroundColor: WidgetStatePropertyAll(Colors.black54),
          side: WidgetStatePropertyAll(
            BorderSide(color: Colors.blue),
          ),
        ),
        onPressed: () {
          context.read<ImageFilterBloc>().add(SaveImageEvent());
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
