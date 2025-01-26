import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/splash.dart';
import 'package:multivendorplatformmobile/features/profile/screens/account.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/router.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

void main() {
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
  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
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
      home: const Splash()
    );
  }
}

