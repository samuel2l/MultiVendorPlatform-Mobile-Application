// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/cart_item.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';

import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class WishlistService extends ChangeNotifier{
 void editWishlist(
      {required BuildContext context,
      required Product product,
      required int amount,
      bool isRemove = false}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.put(
        Uri.parse('$productsUri/wishlist'),
        headers: {
          'Authorization': 'Bearer ${userProvider.user.token}',
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "product": {
            "_id": product.id,
          },
          "amount": amount,
          "isRemove": isRemove
        }),
      );
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
}
