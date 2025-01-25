import 'package:multivendorplatformmobile/features/models/order_item.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:multivendorplatformmobile/features/wishlist/services/wishlist_service.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sale extends StatefulWidget {
  const Sale({
    super.key,
    required this.order,
  });

  final OrderItem order;

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  SellerService sellerService = SellerService();

  String? result;
  // void mapItemColors() {
  //   Map<String, int> itemCounts = {};
  //   for (var color in widget.order.items.colors!) {
  //     itemCounts[color] = (itemCounts[color] ?? 0) + 1;
  //   }
  //   result = itemCounts.entries
  //       .map((entry) => '${entry.key}: ${entry.value}')
  //       .join(', ');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
 color: Colors.red,
 margin: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.order.orderId,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.order.customerId,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${widget.order.amount}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
Column(children:  (widget.order.items).map((product) {
                      return Container(
                          color: Colors.red,
                          height: 40,
                          child: Column(
                            children: [
                              Text(product.name),
                              product.sizes.isEmpty
                                  ? const SizedBox.shrink()
                                  :    Text(product.sizes.join(", ")),
                                                                  product.colors.isEmpty
                                  ? const SizedBox.shrink()
                                  :    Text(product.colors.join(", "))
                  
                            ],
                          ));
                    }).toList(),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
