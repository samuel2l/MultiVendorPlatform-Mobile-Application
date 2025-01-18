// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller_products.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SellerService {
  void addNewProduct({
    required BuildContext context,
    required String name,
    required double price,
    required String description,
    required int stock,
    required String type,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<String> imgUrls = [];
      final cloudinary = CloudinaryPublic('dvsd4zjxf', 'ztkl4b1w');
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,
              resourceType: CloudinaryResourceType.Image, folder: name),
        );

        imgUrls.add(response.secureUrl);
      }
      http.Response response = await http.post(
        Uri.parse('$productsUri/product/create'),
        headers: {
          'Authorization': "Bearer ${userProvider.user.token}",
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          "name": name,
          "desc": description,
          "img": imgUrls[0],
          "type": type,
          "stock": stock,
          "price": price,
        }),
      );
      print("response from ADD PRODUCT APU");
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.of(context).pushNamedAndRemoveUntil(
              Seller.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  getAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.get(
        Uri.parse('$productsUri/seller-products'),
        headers: {
          'Authorization': "Bearer ${userProvider.user.token}",
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
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

      return response.body;
    } catch (e) {
      showSnackBar(context, 'Something went wrong');
    }
  }

  void deleteProduct({
    required BuildContext context,
    required String id,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$productsUri/product/$id'),
        headers: {
          'Authorization': "Bearer ${userProvider.user.token}",
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product deleted successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void updateProduct({
    required BuildContext context,
    required String name,
    required double price,
    required String description,
    required int stock,
    required String type,
    required List<File> images,
    required String id,
    bool available = true,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<String> imgUrls = [];
      final cloudinary = CloudinaryPublic('dvsd4zjxf', 'ztkl4b1w');
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,
              resourceType: CloudinaryResourceType.Image, folder: name),
        );

        imgUrls.add(response.secureUrl);
      }
      http.Response response = await http.patch(
        Uri.parse('$productsUri/product/$id'),
        headers: {
          'Authorization': "Bearer ${userProvider.user.token}",
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          "name": name,
          "desc": description,
          "img": imgUrls[0],
          "type": type,
          "stock": stock,
          "price": price,
          "available": available
        }),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(
              context,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
