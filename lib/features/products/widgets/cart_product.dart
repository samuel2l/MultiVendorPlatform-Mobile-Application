// ignore_for_file: use_build_context_synchronously

import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    super.key,
    required this.index,
  });

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  void initState() {
    super.initState();
    // Initialize quantity from the cart item
    final cartItem = context.read<UserProvider>().user.cart[widget.index];
    print(cartItem.product.colors);
    quantity = cartItem.amount;
    colors = cartItem.product.colors;
    sizes = cartItem.product.colors;
  }

  final ProductDetailsService productDetailsService = ProductDetailsService();

  int? quantity;
  List<String>? colors;
  List<String>? sizes;

  void incrementQuantity() {
    setState(() {
      quantity = quantity! + 1;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity! > 1) quantity = quantity! - 1;
    });
  }

  void editCart(Product product, bool isRemove) {
    productDetailsService.editCart(
        context: context,
        product: product,
        amount: quantity!,
        isRemove: isRemove,
        selectedColors: [],
        selectedSizes: [],
        isUpdateQuantityOnly: true);

    setState(() {});
  }

  String? result;
  void mapItemColors() {
    Map<String, int> itemCounts = {};
    for (var color in colors!) {
      itemCounts[color] = (itemCounts[color] ?? 0) + 1;
    }
    result = itemCounts.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = context.watch<UserProvider>().user.cart[widget.index];
    colors!.isEmpty ? null : mapItemColors();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                cartItem.product.img.isNotEmpty == true
                    ? cartItem.product.img[0]
                    : 'https://via.placeholder.com/150',
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      cartItem.product.name,
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
                      '\$${cartItem.product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      colors!.isNotEmpty ? 'Colors: $result' : "${cartItem.amount} in cart",
                      style: const TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () async{
                // editCart(cartItem.product, false);
                Product product = await productDetailsService.getProduct(
                    cartItem.product.id, context);
                Navigator.of(context).pushNamed(ProductDetails.routeName,
                    arguments: product);
              },
              child: const Text('edit'),
            ),
            IconButton(
              onPressed: () {
                editCart(cartItem.product, true);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
