import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/auth/screens/login.dart';
import 'package:multivendorplatformmobile/features/auth/screens/signup.dart';
import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/input_field.dart';
import 'package:multivendorplatformmobile/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final signUpKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String selectedValue = "Buyer";

  void login(BuildContext context) {
    authService.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    TapGestureRecognizer tapRecognizer = TapGestureRecognizer();
    tapRecognizer.onTap = () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const Signup();
          },
        ),
        (route) => false,
      );
    };

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Log in",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.light
                        ? ash
                        : lightAsh),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(color: teal),
                      recognizer: tapRecognizer),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: signUpKey, // Add the key here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Enter email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null; //means input has been validated
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null; //means input has been validated
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  TextButton(
                    onPressed: () {
                      if (signUpKey.currentState!.validate()) {
                        // signUp(context);
                        print(emailController.text);
                        print(passwordController.text);
                        print(phoneController.text);
                        print(selectedValue);
                      }
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
