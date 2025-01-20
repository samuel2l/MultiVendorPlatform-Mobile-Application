// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/models/profile.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:provider/provider.dart';

class ProfileService {
  void updateProfile(
      {required String name,
      required File? img,
      required String gender,
      required String street,
      required String postalCode,
      required String city,
      required String country,
      required BuildContext context}) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    String token = user.token;
    http.Response response;
    try {
      if (img != null) {
        final cloudinary = CloudinaryPublic('dvsd4zjxf', 'ztkl4b1w');
        CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(img.path,
              resourceType: CloudinaryResourceType.Image, folder: name),
        );

        response = await http.put(
          Uri.parse('$uri/profile'),
          body: jsonEncode({
            "name": name,
            "img": cloudinaryResponse.secureUrl,
            "gender": gender,
            "street": street,
            "postalCode": postalCode,
            "city": city,
            "country": country
          }),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
      } else {
        response = await http.put(
          Uri.parse('$uri/profile'),
          body: jsonEncode({
            "name": name,
            "gender": gender,
            "street": street,
            "postalCode": postalCode,
            "city": city,
            "country": country
          }),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
      }
      print("EDIT PROFILE RESPONSE");
      print(response.body);
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            print("before updated profile???????");
            Profile updatedProfile =
                Profile.fromMap(jsonDecode(response.body));
            print("updatyed profileee?????");
            print(updatedProfile);

            Provider.of<UserProvider>(context, listen: false)
                .setUserFromModel(user.copyWith(profile: updatedProfile));
            print("UPDATED USER PROFILEEEEE");
            print(user.profile);

            Navigator.of(context).pushNamedAndRemoveUntil(
              BottomNavBar.routeName,
              (route) => false,
            );
            showSnackBar(context, 'Account created!');
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
