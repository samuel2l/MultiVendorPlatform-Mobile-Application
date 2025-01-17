// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/models/cartItem.dart';
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
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            Provider.of<UserProvider>(context, listen: false).setUserFromModel(
                User(
                    email: email,
                    phone: phone,
                    role: role,
                    cart: [],
                    wishlist: [],
                    orders: [],
                    token: jsonDecode(response.body)["token"]));
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('x-auth-token', jsonDecode(response.body)["token"]);

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
      print("logiun respinse");
      print(response.body);
      http.Response currentUser = await http.get(
        Uri.parse('$uri/'),
        headers: <String, String>{
          'Authorization': 'Bearer ${jsonDecode(response.body)["token"]}',
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': jsonDecode(response.body)["token"]
        },
      );
      print("current user");
      print(currentUser.body);
      var userData = jsonDecode(currentUser.body);

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('x-auth-token', jsonDecode(response.body)["token"]);

            Provider.of<UserProvider>(context, listen: false)
                .setUserFromModel(User.fromMap({
              "email": userData["email"],
              "phone": userData["phone"],
              "role": userData["role"],
              "cart": userData["cart"],
              "wishlist": userData["wishlist"],
              "orders": userData["orders"],
              "token": jsonDecode(response.body)["token"]
            }));
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomNavBar.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

//   void getUserData(
//     BuildContext context,
//   ) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('x-auth-token');
//       if (token == null) {
//         prefs.setString('x-auth-token', '');
//       }

//       if (token != '' && token != null) {
//         print("gotten token is $token");

//         http.Response userRes = await http.get(
//           Uri.parse('$uri/'),
//           headers: <String, String>{
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json; charset=UTF-8',
//           },
//         );
//         print("user res");
//         print(userRes.body);
//         var userData = jsonDecode(userRes.body);
//         print("type of list???????");
//         print(userData["orders"]);
//         print(userData["orders"].length);
//         (userData["orders"] as List<dynamic>)
//             .map((item) => {
//                   item =
//                       CartItem(product: item["product"], amount: item["amount"])
//                 })
//             .toList();
//         print("after operation");
//         print(userData.runtimeType);

//         User user = User(
//             email: userData["email"],
//             phone: userData["phone"],
//             role: userData["role"],
//             cart: userData["cart"],
//             wishlist: userData["wishlist"],
//             orders: userData["orders"],
//             token: token);
//         print(user);
//         print(user.runtimeType);
//         print("${user.token} ${user.email} ${user.phone}  ");
//         Provider.of<UserProvider>(context, listen: false)
//             .setUserFromModel(user);
//         print(
//             "in get user data???????????????? ${Provider.of<UserProvider>(context, listen: false).user} ");
//       }
//     } catch (e) {
//       // showSnackBar(context, e.toString());
//       print("error");
//       print(e);
//     }
//   }
// }
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print("gotten token is $token");
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      if (token != '' && token != null) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
        var userData = jsonDecode(userRes.body);

        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(User.fromMap({
          "email": userData["email"],
          "phone": userData["phone"],
          "role": userData["role"],
          "cart": userData["cart"],
          "wishlist": userData["wishlist"],
          "orders": userData["orders"],
          "token": token
        }));
      }
      print("done?????????");
    } catch (e) {
      print("error");
      print(e);
      // showSnackBar(context, e.toString());
    }
  }
}
