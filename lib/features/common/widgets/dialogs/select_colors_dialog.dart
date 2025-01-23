import 'package:flutter/material.dart';

class SelectColorsDialog extends StatefulWidget {
  const SelectColorsDialog({super.key});

  @override
  State<SelectColorsDialog> createState() => _SelectColorsDialogState();
}

class _SelectColorsDialogState extends State<SelectColorsDialog> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child:  Text('You are tryign to select more sizes than amount to be added to your cart'),
    );
  }
}
