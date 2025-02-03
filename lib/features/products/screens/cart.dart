// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:multivendorplatformmobile/features/orders/services/order_service.dart';
import 'package:multivendorplatformmobile/features/products/widgets/cart_product.dart';
import 'package:multivendorplatformmobile/features/search/screens/search.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity = 1;
  void navigateToSearch(String query) {
    Navigator.pushNamed(context, Search.routeName, arguments: query);
  }

  OrderService orderService = OrderService();
  Future<void> initPaymentSheet(
      BuildContext context, User user, double total) async {
    try {
      http.Response response =
          await http.post(Uri.parse('$shoppingUri/create-payment-intent'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({"total": total * 100}));
      final data = jsonDecode(response.body);
      print("DATA FROM STRIPE API");
      print(data);

      final paymentIntent = data['paymentIntent'];
      final ephemeralKey = data['ephemeralKey'];
      final customer = data['customer'];
      const publishableKey =
          "pk_test_51QUj13KvYI3VPzXg09FJihE8d7S6TZhH1snWgfyn7AcwjQkDX1UMYIyqkeBusWVT7VC8B4jSllmjVfYMmF9knYho00dQKl01Bv";

      Stripe.publishableKey = publishableKey;
      BillingDetails billingDetails = BillingDetails(
        email: user.email,
        phone: user.phone,
        name: user.profile.name,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'MOBIZATE',
          paymentIntentClientSecret: paymentIntent,
          customerEphemeralKeySecret: ephemeralKey,
          customerId: customer,
          style: ThemeMode.light,
          billingDetails: billingDetails,
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'IN',
            currencyCode: 'usd',
            testEnv: true,
          ),
        ),
      );

      await Stripe.instance
          .presentPaymentSheet()
          .then((value) {})
          .onError((error, stackTrace) {
        if (error is StripeException) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('${error.error.localizedMessage}')),
          // );
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Stripe Error: $error')),
          // );
        }
      });
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Error initializing payment: $e')),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(e.toString())),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double total = 0;
    print("ei?");
    for (var item in user.cart) {
      total = total + (item.amount * item.product.price).toDouble();
    }
    print("NEW TOTAL $total");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          user.cart.isEmpty
              ? const Center(
                  child: Text("You have no items in your cart"),
                )
              : ListView.builder(
                  itemCount: user.cart.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CartProduct(
                      index: index,
                    );
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text(
                'Checkout \$$total (${user.cart.length} items)',
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                await initPaymentSheet(context, user, total);
               await orderService.placeOrder(context: context);
              },
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) {
              //     return PaymentScreen();
              //   },
              // )),
            ),
          ),
        ],
      ),
    );
  }
}
