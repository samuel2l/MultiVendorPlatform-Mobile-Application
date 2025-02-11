import 'package:multivendorplatformmobile/features/models/cart_item.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/wishlist/services/wishlist_service.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistItem extends StatefulWidget {
  final CartItem item;
  const WishlistItem({
    super.key,
    required this.item,
  });

  @override
  State<WishlistItem> createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  @override
  void initState() {
    super.initState();
  }

  final WishlistService wishlistService = WishlistService();

  int? quantity;
  List<String>? sizes;
  List<String>? colors;

  void editWishlist(Product product, bool isRemove) {
    wishlistService.editWishlist(
        context: context,
        product: product,
        amount: widget.item.amount,
        isRemove: isRemove,
        isUpdateQuantityOnly: true);

    setState(() {});
  }

  void moveToCart(Product product) {
    wishlistService.moveFromWishlistToCart(
      context: context,
      product: product,
      amount: widget.item.amount,
    );

    setState(() {});
  }

  String? result;
  // void mapItemColors() {
  //   Map<String, int> itemCounts = {};
  //   for (var color in colors!) {
  //     itemCounts[color] = (itemCounts[color] ?? 0) + 1;
  //   }
  //   result = itemCounts.entries
  //       .map((entry) => '${entry.key}: ${entry.value}')
  //       .join(', ');
  // }

  @override
  Widget build(BuildContext context) {
    // mapItemColors();
    print(widget.item.product.img);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(widget.item.product.img[0],height: 155,width:155,),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.item.product.name,
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
                      '\$${widget.item.product.price}',
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
                     "Amount added: ${widget.item.amount.toString()}",
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Product product = await wishlistService.getProduct(
                      widget.item.product.id, context);
                  Navigator.of(context)
                      .pushNamed(ProductDetails.routeName, arguments: product);
                },
                child: const Text('edit'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                editWishlist(widget.item.product, true);
                moveToCart(widget.item.product);
                
              },
              child: const Text('Move to cart'),
            ),
            IconButton(
              onPressed: () {
                editWishlist(widget.item.product, true);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
