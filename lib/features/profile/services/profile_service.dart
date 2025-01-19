// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/models/profile.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  void updateProfile(
      {required String name,
      required String gender,
      required String street,
      //   name,gender,street, postalCode, city, country
      required String postalCode,
      required String city,
      required String country,
      required BuildContext context}) async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    String token = user.token;
    try {
      http.Response response = await http.put(
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
      print("EDIT PROFILE RESPONSE");
      print(response.body);
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            Profile updatedProfile =
                Profile.fromJson(jsonEncode(response.body));

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
