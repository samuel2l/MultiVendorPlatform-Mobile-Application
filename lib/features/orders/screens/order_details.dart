import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/models/order.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:multivendorplatformmobile/features/orders/widgets/order_product.dart';
import 'package:multivendorplatformmobile/features/seller/widgets/seller_bottom_navbar.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      bottomNavigationBar: user.role == 'Seller'
          ? const SellerBottomNavbar()
          : const BottomNavBar(),
      appBar: AppBar(),
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
