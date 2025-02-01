// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchService {
  getProducts(String query, BuildContext context) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$productsUri/search/$query'),
      );

      print("response from search api");
      print(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Products loaded successfully');
        },
      );
      List<Product> products =
          (jsonDecode(response.body) as List).map((product) {
        return Product.fromMap(product);
      }).toList();

      print(products);
      return products;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  searchProductsInCategory(
      String productQuery, String category, BuildContext context) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$productsUri/category-search/$category/$productQuery'),
      );

      print("response from search api");
      print(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Products loaded successfully');
        },
      );
      List<Product> products =
          (jsonDecode(response.body) as List).map((product) {
        return Product.fromMap(product);
      }).toList();
      print("returning products");
      print(products);
      return products;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  searchSellerProducts(
      String productQuery, String sellerId, BuildContext context) async {
    try {
      print(sellerId);
      http.Response response = await http.get(
        Uri.parse('$productsUri/seller-search/$sellerId/$productQuery'),
      );

      print("response from search api");
      print(response.body);
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Products loaded successfully');
        },
      );
      List<Product> products =
          (jsonDecode(response.body) as List).map((product) {
        return Product.fromMap(product);
      }).toList();
      print("returning products");
      print(products);
      return products;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }
}
