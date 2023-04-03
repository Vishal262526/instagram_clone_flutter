import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.keyboardType,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0)
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
    );
  }
}
