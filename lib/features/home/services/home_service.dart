// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeService {
  getProductsByCategory({
    required BuildContext context,
    required String category,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$productsUri/category/$category'),
      );
      print("RESPONSE FROM API");
      print(response.body);
      httpErrorHandle(
          response: response,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Products loaded successfully');
          });
      var data=jsonDecode(response.body);
      return data;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
