// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/cart_item.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';

import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../models/profile.dart';

class ProductDetailsService extends ChangeNotifier {
  //extend change notifier so we can use .notifyListeners to update in real time
  void editCart(
      {required BuildContext context,
      required Product product,
      required int amount,
      List<String> selectedColors = const [],
      List<String> selectedSizes = const [],
      bool isRemove = false,
      bool isUpdateQuantityOnly = false}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print("tokennnn from");
    print(userProvider.user.token);

    http.Response? res;
    try {
      if (isUpdateQuantityOnly || isRemove) {
        print("trying to delete?");
        res = await http.put(
          Uri.parse('$productsUri/cart'),
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
              "sizes": selectedSizes,
              "colors": selectedColors
            },
            "amount": amount,
            "isRemove": isRemove
          }),
        );
      }
      print("from edit cart api");
      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Cart updated');
          // instead of keeping the cart as part of state management you could just call api using the req.user id
          CartItem cartItem = CartItem(
              product: Product.fromMap(jsonDecode(res!.body)["product"]),
              amount: amount);
          if (isRemove == true) {
            print("is remove is true?");
            userProvider.user.cart
                .removeWhere((item) => item.product.id == product.id);
          } else {
            int existingItemIndex = userProvider.user.cart.indexWhere(
              (item) => item.product.id == cartItem.product.id,
            );

            if (existingItemIndex != -1) {
              userProvider.user.cart[existingItemIndex] = cartItem;
            } else {
              userProvider.user.cart.add(cartItem);
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

  getSellerProfile(String sellerId, BuildContext context) async {
    http.Response res = await http.get(
      Uri.parse('$uri/seller-profile/$sellerId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
    print("from get profile api");
    print(res.body);

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        showSnackBar(context, 'gotten seller profile');
      },
    );
    Profile profile = Profile.fromMap(jsonDecode(res.body));
    print("did the profule cast work>>>>>");
    print(profile);
    return profile;
  }

  getSellerProducts(BuildContext context, String id) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$productsUri/seller-products/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("response from get sellers products api");
      print(response.body);
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Products loaded successfully');
          });

      List<Product> productList = (jsonDecode(response.body) as List)
          .map(
            (product) => Product.fromMap(product),
          )
          .toList();
      print("did product list workkkkkk");
      print(productList);
      return productList;
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }
  }

  getProduct(String productId, BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse('$productsUri/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("get product api resonns");
      print(res.body);
      var productDetails = jsonDecode(res.body);
      Product product = Product.fromMap(productDetails);
      return product;
    } catch (e) {
      print("error");
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
