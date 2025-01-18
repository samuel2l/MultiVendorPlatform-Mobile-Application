import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/models/order_item.dart';

class Order extends StatelessWidget {
  const Order({super.key, required this.orderItem});
  final OrderItem orderItem;
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: orderItem.items.length,
    //   itemBuilder: (context, index) {
    //     return Text(orderItem.amount.toString());
    //   },
    // );
    print(orderItem.items[0]);
    print(orderItem.items[0].desc);
    print(orderItem.items[0].name);
    print(orderItem.items[0].name);
    print(orderItem.amount);
    
    return Text(orderItem.items[0].name);
  }
}
