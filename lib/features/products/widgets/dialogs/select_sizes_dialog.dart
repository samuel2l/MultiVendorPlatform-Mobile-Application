import 'package:flutter/material.dart';

class SelectSizesDialog extends StatelessWidget {
  const SelectSizesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child:  Text('You are tryign to select more sizes than amount to be added to your cart'),
    );
  }
}
