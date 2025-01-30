import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
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
  final ProductDetailsService productDetailsService = ProductDetailsService();

  int quantity = 1;
  void navigateToSearch(String query) {
    Navigator.pushNamed(context, Search.routeName, arguments: query);
  }

  Future<void> initPaymentSheet(context) async {
    try {

      http.Response response = await http.post(
        Uri.parse('$shoppingUri/create-payment-intent'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final data = jsonDecode(response.body);
      print("DATA FROM STRIPE API");
      print(data);

      final paymentIntent = data['paymentIntent'];
      final ephemeralKey = data['ephemeralKey'];
      final customer = data['customer'];
      const publishableKey =
          "pk_test_51QUj13KvYI3VPzXg09FJihE8d7S6TZhH1snWgfyn7AcwjQkDX1UMYIyqkeBusWVT7VC8B4jSllmjVfYMmF9knYho00dQKl01Bv";

      Stripe.publishableKey = publishableKey;
      BillingDetails billingDetails = const BillingDetails(
        email: 'test@example.com',
        phone: '+1234567890',
        name: 'Test User',
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

      await Stripe.instance.presentPaymentSheet().then((value) {
      }).onError((error, stackTrace) {
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

  void navigateToAddress(int sum) {
    // Navigator.of(context).pushNamed(Address.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearch,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Everything beyond your imagination is here',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          // const AddressBox(),
          // const CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('Proceed to Buy (${user.cart.length} items)'),
              onPressed: () {
                initPaymentSheet(context);
              },
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) {
              //     return PaymentScreen();
              //   },
              // )),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
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
        ],
      ),
    );
  }
}
