import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/splash.dart';
import 'package:multivendorplatformmobile/features/home/screens/categories.dart';
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
    // var user = Provider.of<UserProvider>(context);
    return MaterialApp(
      title: 'Multivendor Platform',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.role == 'Buyer'
      //         ? const BottomNavBar()
      //         : const Admin()
      //     : const Auth(),
      home: const Categories(),
    );
  }
}
