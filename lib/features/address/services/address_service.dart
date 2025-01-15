// import 'dart:convert';

// import 'package:multivendorplatformmobile/constants.dart';
// import 'package:multivendorplatformmobile/features/models/user.dart';
// import 'package:multivendorplatformmobile/providers/user_provider.dart';
// import 'package:multivendorplatformmobile/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class AddressService extends ChangeNotifier {
//   void saveUserAddress({
//     required BuildContext context,
//     required String address,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/user/add-address'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': userProvider.user.token,
//         },
//         body: jsonEncode({
//           'address': address,
//         }),
//       );

//       httpErrorHandle(
//         response: res,
//         // ignore: use_build_context_synchronously
//         context: context,
//         onSuccess: () {
//           User user = userProvider.user.copyWith(
//             address: jsonDecode(res.body)['address'],
//           );

//           userProvider.setUserFromModel(user);
//         },
//       );
//       userProvider.notifyListeners();
//     } catch (e) {
//       // ignore: use_build_context_synchronously
//       showSnackBar(context, e.toString());
//     }
//   }

//   void placeOrder({
//     required BuildContext context,
//     required String address,
//   }) async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);

//     try {
//       http.Response res = await http.post(Uri.parse('$uri/product/order'),
//           headers: {
//             'Content-Type': 'application/json; charset=UTF-8',
//             'x-auth-token': userProvider.user.token,
//           },
//           body: jsonEncode({
//             'address': address,
//           }));

//       httpErrorHandle(
//         response: res,
//         // ignore: use_build_context_synchronously
//         context: context,
//         onSuccess: () {
//           showSnackBar(context, 'Your order has been placed!');
//           showSnackBar(context, res.body);
//           User user = userProvider.user.copyWith(
//             cart: [],
//           );
//           userProvider.setUserFromModel(user);
//           Navigator.of(context).pop();
//         },
//       );
//     } catch (e) {
//       // ignore: use_build_context_synchronously
//       showSnackBar(context, e.toString());
//     }
//   }

//   void getOrders({
//     required BuildContext context,
//   }) async {
//     try {
//       final userProvider = Provider.of<UserProvider>(context, listen: false);

//       http.Response res = await http.get(
//         Uri.parse('$uri/product/get-orders'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': userProvider.user.token,
//         },
//       );
//        jsonDecode(res.body);
//     } catch (err) {
//       showSnackBar(context, err.toString());
//     }
//   }
// }
