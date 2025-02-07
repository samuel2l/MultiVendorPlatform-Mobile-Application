// import 'package:multivendorplatformmobile/features/auth/services/auth_service.dart';
// import 'package:flutter/material.dart';

// class Auth extends StatefulWidget {
//   static const String routeName = 'auth';
//   const Auth({super.key});

//   @override
//   State<Auth> createState() => _AuthState();
// }

// class _AuthState extends State<Auth> {
//   String auth = 'signUp';
//   final signUpKey = GlobalKey<FormState>();
//   final logInKey = GlobalKey<FormState>();
//   final AuthService authService = AuthService();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController roleController = TextEditingController();

//   @override
//   void dispose() {
//     phoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     roleController.dispose();
//     super.dispose();
//   }

//   void signUp(BuildContext context) {
//     authService.signUp(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//       phone: phoneController.text.trim(),
//       role: roleController.text.trim(),
//       context: context,
//     );
//   }

//   void login(BuildContext context) {
//     authService.login(
//       password: passwordController.text.trim(),
//       email: emailController.text.trim(),
//       context: context,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: SafeArea(
//         child: Column(
//           children: [
//             ListTile(
//               title: const Text('Create account'),
//               leading: Radio(

//                 value: 'signUp',
//                 groupValue: auth,
//                 onChanged: (value) => setState(() {
//                   auth = value!;
//                 }),
//               ),
//             ),
//             auth == 'signUp'
//                 ? Form(
//                     key: signUpKey, // Add the key here
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           TextFormField(
//                             controller: emailController,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter email',
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black26),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black26),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               return null; //means input has been validated
//                             },
//                           ),
//                           const SizedBox(height: 8),
//                           TextFormField(
//                             controller: passwordController,
//                             obscureText: true,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter your password',
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black26),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your password';
//                               }
//                               return null; //means input has been validated
//                             },
//                           ),
//                           const SizedBox(height: 8),
//                           TextFormField(
//                             controller: phoneController,
//                             keyboardType: TextInputType.number,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter a phone number',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter a password';
//                               }

//                               return null; //means input has been validated
//                             },
//                           ),
//                           TextFormField(
//                             controller: roleController,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter your role in the app',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your role';
//                               }

//                               return null; //means input has been validated
//                             },
//                           ),
//                           const SizedBox(height: 8),
//                           TextButton(
//                             onPressed: () {
//                               if (signUpKey.currentState!.validate()) {
//                                 signUp(context);
//                               }
//                             },
//                             child: const Text('Sign Up'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             ListTile(
//               title: const Text('Log in'),
//               leading: Radio(

//                 value: 'logIn',
//                 groupValue: auth,
//                 onChanged: (value) => setState(() {
//                   auth = value!;
//                 }),
//               ),
//             ),
//             auth == 'logIn'
//                 ? Form(
//                     key: logInKey,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           TextFormField(
//                             controller: emailController,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter your email',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               return null; //means input has been validated
//                             },
//                           ),
//                           const SizedBox(height: 8),
//                           TextFormField(
//                             controller: passwordController,
//                             obscureText: true,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter your password',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your password';
//                               }
//                               return null; //means input has been validated
//                             },
//                           ),
//                           const SizedBox(height: 8),
//                           TextButton(
//                             onPressed: () {
//                               if (logInKey.currentState!.validate()) {
//                                 login(context);
//                               }
//                             },

//                             child: const Text('Log In'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ],
//         ),
//       ),
//     );
//   }
// }
