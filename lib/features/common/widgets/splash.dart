// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/features/auth/screens/auth.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    // Fetch user data or perform necessary startup logic
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token') ?? '';
    AuthService authService = AuthService();
    if (token.isNotEmpty) {
      await authService.getUserData(context);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      print("in initialize app");
      print(userProvider.user.email);
      print(userProvider.user.role);
      print(userProvider.user.token);
      print(userProvider.user.cart);
      print(userProvider.user.orders);

      if (userProvider.user.role == 'Buyer') {
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomNavBar.routeName,
          (route) => false,
        );
      } else if (userProvider.user.role == 'Seller') {
        print("seller?");
        Navigator.of(context).pushNamedAndRemoveUntil(
          Seller.routeName,
          (route) => false,
        );
      } else {
        Navigator.push(
          context,MaterialPageRoute(
            
          builder: (context) {
            return Center(child: Text("You are not a suitable user of this app"));
          },
        ),

        );
      }
    } else {
      print("auth??");
      Navigator.of(context).pushNamedAndRemoveUntil(
        Auth.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
