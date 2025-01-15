// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/models/profile.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUp(
      {required String phone,
      required String password,
      required String email,
      required String role,
      required BuildContext context}) async {
    try {
      // User user = User(
      //   id: '',
      //   name: name,
      //   password: password,
      //   address: '',
      //   type: '',
      //   token: '',
      //   email: email,
      //   cart: [],
      // );

      http.Response response = await http.post(
        Uri.parse('$uri/signup'),
        body: jsonEncode({
          "email": email,
          "password": password,
          "phone": phone,
          "role": role,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("RESPONSE FROM API ${response.body}");
      print(response.body.runtimeType);
      print(response.runtimeType);

//       http.Response currentUser = await http.get(
//         Uri.parse('$uri/'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': jsonDecode(response.body)["token"]
//         },
//       );
//       print("current user");
// print(currentUser);
      httpErrorHandle(
          response: response,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            print('token ${jsonDecode(response.body)["token"]} ');

            Provider.of<UserProvider>(context, listen: false).setUserFromModel(
                User(
                    email: email,
                    password: password,
                    phone: phone,
                    role: role,
                    profile: Profile(
                        name: '',
                        gender: '',
                        street: '',
                        postalCode: '',
                        city: '',
                        country: ''),
                    cart: [],
                    wishlist: [],
                    orders: [],
                    token: ''));
            // print("USEr");
            // print(Provider.of<UserProvider>(context).user);

            Navigator.of(context).pushNamedAndRemoveUntil(
              BottomNavBar.routeName,
              (route) => false,
            );
            showSnackBar(context, 'Account created!');
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      print(e.toString());

      showSnackBar(context, e.toString());
    }
  }

  void login(
      {required String password,
      required String email,
      required BuildContext context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      http.Response currentUser = await http.get(
        Uri.parse('$uri/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': jsonDecode(response.body)["token"]
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: response,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('x-auth-token', jsonDecode(response.body)["token"]);
            // ignore: use_build_context_synchronously

            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false)
                .setUser(currentUser.body);
            Navigator.pushNamedAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              BottomNavBar.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      // ignore: use_build_context_synchronously

      print(e);
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
