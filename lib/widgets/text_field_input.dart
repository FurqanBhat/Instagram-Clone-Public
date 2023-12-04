import 'package:flutter/material.dart';
class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  bool obscure=false;
  final String hintText;
  final TextInputType textInputType;
  TextFieldInput({super.key, required this.controller, required this.textInputType, required this.hintText, this.obscure=false});

  @override
  Widget build(BuildContext context) {
    final inputBorder=OutlineInputBorder(
        borderSide: Divider.createBorderSide(context)

    );
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border:inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: obscure,
    );
  }
}
