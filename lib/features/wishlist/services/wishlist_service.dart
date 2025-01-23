// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/cart_item.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';

import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WishlistService extends ChangeNotifier {
  void editWishlist(
      {required BuildContext context,
      required Product product,
      required int amount,
            List<String> selectedColors = const [],
      List<String> selectedSizes = const [],
      
      bool isRemove = false,bool isUpdateQuantityOnly = false}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    http.Response? res;
    try {
      if (isUpdateQuantityOnly) {
        res = await http.put(
          Uri.parse('$productsUri/wishlist'),
          headers: {
            'Authorization': 'Bearer ${userProvider.user.token}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "product": {
              "_id": product.id,
            },
            "amount": amount,
            "isRemove": isRemove
          }),
        );
      } else {
        res = await http.put(
          Uri.parse('$productsUri/cart'),
          headers: {
            'Authorization': 'Bearer ${userProvider.user.token}',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "product": {
              "_id": product.id,
              "sizes":selectedSizes,
              "colors":selectedColors
            },
            "amount": amount,
            "isRemove": isRemove
          }),
        );
      }
      print("from wishlist apiiiii?????????????????");
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Wishlist updated');
          // instead of keeping the cart as part of state management you could just call api using the req.user id
          CartItem wishlistItem = CartItem(product: product, amount: amount);
          if (isRemove == true) {
            userProvider.user.wishlist
                .removeWhere((item) => item.product.id == product.id);
          } else {
            int existingItemIndex = userProvider.user.wishlist.indexWhere(
              (item) => item.product.id == wishlistItem.product.id,
            );

            if (existingItemIndex != -1) {
              userProvider.user.wishlist[existingItemIndex] = wishlistItem;
            } else {
              userProvider.user.wishlist.add(wishlistItem);
            }
          }
          userProvider.notifyListeners();
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  void moveFromWishlistToCart(
      {required BuildContext context,
      required Product product,
      required int amount,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.put(
        Uri.parse('$productsUri/cart'),
        headers: {
          'Authorization': 'Bearer ${userProvider.user.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "product": {
            "_id": product.id,
            "sizes":product.sizes,
            "colors":product.colors
          },
          "amount": amount,
          "isRemove": false
        }),
      );
      print("from move to cart apiiiii?????????????????");
      print(res.body);
      http.Response removedProduct = await http.put(
        Uri.parse('$productsUri/wishlist'),
        headers: {
          'Authorization': 'Bearer ${userProvider.user.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "product": {
            "_id": product.id,
          },
          "amount": amount,
          "isRemove": true
        }),
      );
      print("resoose from remove from wishlist api");
      print(removedProduct.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Moved from wishlist to cart');
          CartItem cartItem = CartItem(product: product, amount: amount);
          userProvider.user.wishlist
              .removeWhere((item) => item.product.id == product.id);

          int existingItemIndex = userProvider.user.cart.indexWhere(
            (item) => item.product.id == cartItem.product.id,
          );

          if (existingItemIndex != -1) {
            userProvider.user.cart[existingItemIndex] = cartItem;
          } else {
            userProvider.user.cart.add(cartItem);
          }

          userProvider.notifyListeners();
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
