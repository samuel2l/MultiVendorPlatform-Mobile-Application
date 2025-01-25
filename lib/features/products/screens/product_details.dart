// ignore_for_file: avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/cart_colors_exceeded.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/select_colors_dialog.dart';
import 'package:multivendorplatformmobile/features/products/widgets/dialogs/select_sizes_dialog.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller_profile.dart';
import 'package:multivendorplatformmobile/features/wishlist/services/wishlist_service.dart';
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

  double avgRating = 0;
  double myRating = 0;

  List<String> selectedColors = [];
  List<String> selectedSizes = [];
  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchScreen(String query) {}
  int quantity = 1;

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
      }else{
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
    print("addimg to art");

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
      }else{
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          CarouselSlider(
            items: widget.product.img.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 300,
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
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                text: 'Price: ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '\$${widget.product.price}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.desc),
          ),
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: addToCart,
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(254, 216, 19, 1),
              ),
              child: const Text('Add to Cart'),
            ),
          ),

          InkWell(
            onTap: () {
              decrementQuantity();
            },
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
          // const SizedBox(height: 10),
          // Container(
          //   color: Colors.black12,
          //   height: 5,
          // ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: addToWishlist,
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(254, 216, 19, 1),
              ),
              child: const Text('Add to Wishlist'),
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
                              showSnackBar(
                                  context, 'this color has not been selected');
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
                                      color:
                                          colorDictionary[color.toLowerCase()],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
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
                  height: 40,
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
                                  return const CartColorsExceeded();
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
                                  context, 'this color has not been selected');
                            }
                            print(selectedSizes);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 30,
                                color: colorDictionary['color'],
                                child: Text(size)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : const SizedBox.shrink(),

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
    );
  }
}
