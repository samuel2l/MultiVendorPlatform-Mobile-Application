import 'dart:io';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void addNewProduct({
    required BuildContext context,
    required String name,
    required double price,
    required String description,
    required int stock,
    required String category,
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
      Product product = Product(
          name: name,
          price: price,
          desc: description,
          stock: stock,
          img: imgUrls[0], id: '', type: category, seller: userProvider.user.email);
      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );
      httpErrorHandle(
          response: response,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(
              context,
            );
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  getAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // try { 
    http.Response response = await http.get(
      Uri.parse('$uri/admin/products'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
    );
    httpErrorHandle(
        response: response,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Products loaded successfully');
        });

    return response.body;
  }

  void deleteProduct({
    required BuildContext context,
    required String id,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/products/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandle(
          response: response,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product deleted successfully');
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void updateProduct(
      {required BuildContext context,
      required String name,
      required double price,
      required String description,
      required int stock,
      required String category,
      required List<File> images,
      required String id}) async {
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
      Product product = Product(
          name: name,
          price: price,
          desc: description,
          stock: stock,
          img: imgUrls[0], id: '', type: category, seller: userProvider.user.email);
      http.Response response = await http.patch(
        Uri.parse('$uri/admin/product/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );
      httpErrorHandle(
          response: response,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(
              context,
            );
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }


}
