import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/wishlist/services/wishlist_service.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistItem extends StatefulWidget {
  final int index;
  const WishlistItem({
    super.key,
    required this.index,
  });

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  @override
  void initState() {
    super.initState();
    // Initialize quantity from the cart item
    final wishlistItem =
        context.read<UserProvider>().user.wishlist[widget.index];
    quantity = wishlistItem.amount;
    sizes = wishlistItem.product.sizes;
    colors = wishlistItem.product.colors;
  }

  final WishlistService wishlistService = WishlistService();

  int? quantity;
  List<String>? sizes;
  List<String>? colors;

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

  void editWishlist(Product product, bool isRemove) {
    wishlistService.editWishlist(
        context: context,
        product: product,
        amount: quantity!,
        isRemove: isRemove,
        isUpdateQuantityOnly: true);

    setState(() {});
  }

  void moveToCart(Product product) {
    wishlistService.moveFromWishlistToCart(
      context: context,
      product: product,
      amount: quantity!,
    );

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
    mapItemColors();
    final wishlistItem =
        context.watch<UserProvider>().user.wishlist[widget.index];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                wishlistItem.product.img.isNotEmpty == true
                    ? wishlistItem.product.img
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
                      wishlistItem.product.name,
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
                      '\$${wishlistItem.product.price}',
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
                    child:  Text(
                      colors!.isNotEmpty ? 'Colors: $result' : "In stock",
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
              onTap: () {
                if (quantity! >= wishlistItem.product.stock) {
                } else {
                  incrementQuantity();
                }
              },
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
                editWishlist(wishlistItem.product, false);
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                editWishlist(wishlistItem.product, false);
                moveToCart(wishlistItem.product);
              },
              child: const Text('Move to cart'),
            ),
            IconButton(
              onPressed: () {
                editWishlist(wishlistItem.product, true);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
