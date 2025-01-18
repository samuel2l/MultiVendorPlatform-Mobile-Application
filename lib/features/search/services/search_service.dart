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
          (jsonDecode(response.body) as List).map((productJson) {
        print("inside cast");
        print(productJson);
        print(productJson.runtimeType);
        return Product.fromMap(productJson);
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
