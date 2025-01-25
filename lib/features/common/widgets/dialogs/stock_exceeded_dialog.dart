import 'package:flutter/material.dart';

class StockExceededDialog extends StatelessWidget {
  const StockExceededDialog({super.key, required this.stock});
  final int stock;
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Text('the cart amount exceeds product stock of $stock'),
    );
  }
}
