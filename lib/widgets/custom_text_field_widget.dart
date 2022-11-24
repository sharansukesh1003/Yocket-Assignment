import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  const CustomTextFieldWidget({
    super.key,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9_ ]")),
      ],
      controller: textEditingController,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        hintStyle: TextStyle(color: Colors.white70),
        hintText: 'Ex - Water the plants.',
        labelText: 'Add TODO',
        helperStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.task,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white70,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
