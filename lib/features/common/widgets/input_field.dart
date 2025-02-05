import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.controller, required this.hintText, required this.maxLines});
final TextEditingController controller;
final String hintText;
final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          

    ),
    
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
      
    );
  }
}