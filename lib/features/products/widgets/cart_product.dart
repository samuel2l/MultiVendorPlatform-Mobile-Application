import 'package:multivendorplatformmobile/features/models/product.dart';
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
    quantity = cartItem.amount;
  }

  final ProductDetailsService productDetailsService = ProductDetailsService();

  int? quantity;

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
        isRemove: isRemove);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = context.watch<UserProvider>().user.cart[widget.index];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                cartItem.product.images.isNotEmpty == true
                    ? cartItem.product.images[0]
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
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
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
            InkWell(
              onTap: () => decrementQuantity(),
              child: Container(
                width: 35,
                height: 32,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.remove,
                  size: 18,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: 35,
                height: 32,
                alignment: Alignment.center,
                child: Text(
                  quantity.toString(),
                ),
              ),
            ),
            InkWell(
              onTap: () => incrementQuantity(),
              child: Container(
                width: 35,
                height: 32,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.add,
                  size: 18,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                editCart(cartItem.product, false);
              },
              child: const Text('Update'),
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
