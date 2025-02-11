import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/models/order.dart';
import 'package:multivendorplatformmobile/features/orders/widgets/order_product.dart';
import 'package:multivendorplatformmobile/theme.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order ID: ${order.orderId}",
                  style: const TextStyle(fontSize: 17),
                ),
                Text(
                  "Total Cost: \$${order.amount}",
                  style: const TextStyle(fontSize: 22),
                ),
                Text(
                  "Status: ${order.status}",
                  style: TextStyle(
                      color: order.status == "received"
                          ? Colors.orange
                          : order.status == "on the way"
                              ? Colors.blue
                              : teal,
                      fontSize: 20),
                ),
                Text(
                  " Ordered on: ${order.date}",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Order Items",
              style: TextStyle(fontSize: 22),
            ),
          ),
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
