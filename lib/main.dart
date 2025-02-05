import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:multivendorplatformmobile/features/common/widgets/onboarding.dart';
import 'package:multivendorplatformmobile/features/auth/screens/signup.dart';
import 'package:multivendorplatformmobile/features/common/widgets/empty.dart';
import 'package:multivendorplatformmobile/features/common/widgets/splash.dart';
import 'package:multivendorplatformmobile/features/home/screens/categories.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/router.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

void main() {
  Stripe.publishableKey =
      "pk_test_51QUj13KvYI3VPzXg09FJihE8d7S6TZhH1snWgfyn7AcwjQkDX1UMYIyqkeBusWVT7VC8B4jSllmjVfYMmF9knYho00dQKl01Bvyour_publishable_key";
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Multivendor Platform',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        onGenerateRoute: (settings) => generateRoute(settings),
        home:const Splash());
  }
}
