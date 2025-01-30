// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/cart_colors_exceeded.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/cart_sizes_exceeded.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/select_colors_dialog.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/select_sizes_dialog.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller_profile.dart';
import 'package:multivendorplatformmobile/features/wishlist/services/wishlist_service.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:multivendorplatformmobile/utils.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final ProductDetailsService productDetailsService = ProductDetailsService();
  final WishlistService wishlistService = WishlistService();

  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  int quantity = 1;
  bool isReadMore = false;

  @override
  void initState() {
    super.initState();
  }

  void incrementQuantity() {
    if (quantity >= widget.product.stock) {
      //show some dialog
      return;
    }

    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity <= 1) {
      return;
    }
    setState(() {
      quantity--;
    });
  }

  void addToCart() {
    print("addimg to art");

    if (widget.product.sizes.isEmpty && widget.product.colors.isEmpty) {
      productDetailsService.editCart(
          context: context, product: widget.product, amount: quantity);
    } else if (widget.product.sizes.isNotEmpty &&
        widget.product.colors.isEmpty) {
      if (quantity == selectedSizes.length) {
        productDetailsService.editCart(
            context: context,
            product: widget.product,
            amount: quantity,
            selectedSizes: selectedSizes);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectSizesDialog();
          },
        );
      }
    } else if (widget.product.sizes.isEmpty &&
        widget.product.colors.isNotEmpty) {
      if (quantity == selectedColors.length) {
        productDetailsService.editCart(
            context: context,
            product: widget.product,
            amount: quantity,
            selectedColors: selectedColors);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectColorsDialog();
          },
        );
      }
    } else {
      if (quantity == selectedColors.length &&
          quantity == selectedSizes.length) {
        productDetailsService.editCart(
            context: context,
            product: widget.product,
            amount: quantity,
            selectedColors: selectedColors,
            selectedSizes: selectedSizes);
      } else if (quantity == selectedColors.length) {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectSizesDialog();
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectColorsDialog();
          },
        );
      }
    }
  }

  void addToWishlist() {
    print("adding to wishlist");

    if (widget.product.sizes.isEmpty && widget.product.colors.isEmpty) {
      wishlistService.editWishlist(
          context: context, product: widget.product, amount: quantity);
    } else if (widget.product.sizes.isNotEmpty &&
        widget.product.colors.isEmpty) {
      if (quantity == selectedSizes.length) {
        wishlistService.editWishlist(
            context: context,
            product: widget.product,
            amount: quantity,
            selectedSizes: selectedSizes);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectSizesDialog();
          },
        );
      }
    } else if (widget.product.sizes.isEmpty &&
        widget.product.colors.isNotEmpty) {
      if (quantity == selectedColors.length) {
        wishlistService.editWishlist(
            context: context,
            product: widget.product,
            amount: quantity,
            selectedColors: selectedColors);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectColorsDialog();
          },
        );
      }
    } else {
      if (quantity == selectedColors.length &&
          quantity == selectedSizes.length) {
        wishlistService.editWishlist(
            context: context,
            product: widget.product,
            amount: quantity,
            selectedColors: selectedColors,
            selectedSizes: selectedSizes);
      } else if (quantity == selectedColors.length) {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectSizesDialog();
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectColorsDialog();
          },
        );
      }
    }
  }

  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: widget.product.img.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.cover,
                      height: 600,
                      width: double.infinity,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 440,
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: Image.network(
            //     widget.product.img,
            //     fit: BoxFit.cover,
            //     height: 240,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "\$${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.desc,
                style: const TextStyle(
                  color: ash,
                  fontSize: 16,
                ),
                maxLines: isReadMore ? null : 3,
                overflow: isReadMore ? null : TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                isReadMore = !isReadMore;
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  isReadMore ? "Read less" : "Read More",
                  style: const TextStyle(color: teal),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Quantity",
                style: TextStyle(color: ash, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // margin: const EdgeInsets.only(right: 300),
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: lightAsh),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: decrementQuantity,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.remove),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: incrementQuantity,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Available Colors",
                style: TextStyle(color: ash, fontSize: 18),
              ),
            ),

            widget.product.colors.isNotEmpty
                ? SizedBox(
                    height: 80,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: (widget.product.colors).map((color) {
                          return GestureDetector(
                            onDoubleTap: () {
                              if (selectedColors.length >= quantity) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const CartColorsExceeded();
                                  },
                                );
                              } else {
                                selectedColors.add(color);
                              }
                              print(selectedColors);
                            },
                            onTap: () {
                              if (selectedColors.contains(color)) {
                                selectedColors.remove(color);
                              } else {
                                showSnackBar(context,
                                    'this color has not been selected');
                              }
                              print(selectedColors);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 37,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorDictionary
                                              .containsKey(color.toLowerCase())
                                          ? colorDictionary[color.toLowerCase()]
                                          : white,
                                    ),
                                    child: const Center(child: Text("")),
                                  ),
                                  Text(color)
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),

            widget.product.sizes.isNotEmpty
                ? SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.product.sizes.map((size) {
                          return GestureDetector(
                            onDoubleTap: () {
                              if (selectedSizes.length >= quantity) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const CartSizesExceeded();
                                  },
                                );
                              } else {
                                selectedSizes.add(size);
                              }
                              print(selectedSizes);
                            },
                            onTap: () {
                              if (selectedSizes.contains(size)) {
                                selectedSizes.remove(size);
                              } else {
                                showSnackBar(
                                    context, 'this size has not been selected');
                              }
                              print(selectedSizes);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // padding: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: ash),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(sizeMapping[size]!),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),

            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Theme.of(context).brightness==Brightness.light?black:teal
                        ),
                        onPressed: addToWishlist,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Add to Wishlist ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Image.asset("assets/images/shopping-cart.png")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).brightness==Brightness.light?black:teal
                        ),
                        onPressed: addToCart,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Add to Cart ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Image.asset("assets/images/shopping-cart.png")
                          ],
                        ),
                      
                      ),

                    ),
                  ),
                ],
              ),
            ),
            // // const Padding(
            // //   padding: EdgeInsets.symmetric(horizontal: 10.0),
            // //   child: Text(
            // //     'Rate The Product',
            // //     style: TextStyle(
            // //       fontSize: 22,
            // //       fontWeight: FontWeight.bold,
            // //     ),
            // //   ),
            // // ),
            // // RatingBar.builder(
            // //   initialRating: myRating,
            // //   minRating: 1,
            // //   direction: Axis.horizontal,
            // //   allowHalfRating: true,
            // //   itemCount: 5,
            // //   itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            // //   itemBuilder: (context, _) => const Icon(
            // //     Icons.star,
            // //     color: secondaryColor,
            // //   ),
            // //   onRatingUpdate: (rating) {
            // //     // productDetailsService.rateProduct(
            // //     //   context: context,
            // //     //   product: widget.product,
            // //     //   rating: rating,
            // //     // );
            // //   },
            // // ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SellerProfile.routeName,
                      arguments: {"sellerId": widget.product.seller});
                },
                child: const Text(
                  'View seller details',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
