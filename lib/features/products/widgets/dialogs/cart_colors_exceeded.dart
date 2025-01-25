import 'package:flutter/material.dart';

class CartColorsExceeded extends StatefulWidget {
  const CartColorsExceeded({super.key});

  @override
  State<CartColorsExceeded> createState() => _CartColorsExceededState();
}

class _CartColorsExceededState extends State<CartColorsExceeded> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child:  Text('You are tryign to select more colors than amount to be added to your cart'),
    );
  }
}
