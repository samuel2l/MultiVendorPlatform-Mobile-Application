// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/auth/screens/signup.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/onboarding.dart';
import 'package:multivendorplatformmobile/theme.dart';
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
    print("gotten token???");
    print(token);
    AuthService authService = AuthService();
    if (token.isNotEmpty) {
      await authService.getUserData(context);

      final userProvider = Provider.of<UserProvider>(context, listen: false);

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
        Navigator.of(context).pushNamedAndRemoveUntil(
          Onboarding.routeName,
          (route) => false,
        );
      }
    } else {
      print("auth??");
      Navigator.of(context).pushNamedAndRemoveUntil(
        Onboarding.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Container(height: 100,),
         Image.asset("assets/images/elogo.png")
          ,
          const Center(
            child: CircularProgressIndicator(color: teal,strokeWidth: 7,),
          ),
          const SizedBox(height: 40,)
        ],
      ),
    );
  }
}
