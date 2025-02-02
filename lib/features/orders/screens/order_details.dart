import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/models/order.dart';
import 'package:multivendorplatformmobile/features/orders/widgets/order_product.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          
          Expanded(
              child: ListView.builder(
            itemCount: order.items.length,
            itemBuilder: (context, index) {
              return OrderProduct(product: order.items[index]);
            },
          ))
        ],
      ),
    );
  }
}
