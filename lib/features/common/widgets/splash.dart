// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/features/auth/screens/auth.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/admin/screens/admin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      // Assume user is logged in and fetch user data
      await authService.getUserData(context);

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      print("in initialize app");
      print(userProvider.user.email);

      if (userProvider.user.role == 'Buyer') {
        Navigator.of(context).pushNamedAndRemoveUntil(
          BottomNavBar.routeName,
          (route) => false,
        );
      } else {
        print("seller?");
        Navigator.of(context).pushNamedAndRemoveUntil(
          Admin.routeName,
          (route) => false,
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
