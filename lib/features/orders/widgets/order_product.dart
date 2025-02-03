import 'package:multivendorplatformmobile/features/models/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';

class OrderProduct extends StatelessWidget {
  final OrderItemModel product;
  const OrderProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetails.routeName,
          arguments: product.product,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                        image: NetworkImage(
                          product.product.img[0],
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.product.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${product.product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    product.product.desc,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.teal, fontSize: 17),
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "${product.amountBought.toString()} ordered",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
