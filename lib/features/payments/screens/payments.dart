import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();

  Future<void> makePayment() async {
    try {
      // Step 1: Collect Card Details
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['clientSecret'],
          merchantDisplayName: 'Your Business Name',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Successful")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment Failed: $e")));
    }
  }

  Future<void> createPaymentIntent() async {
    try {
      final amount = int.tryParse(amountController.text) ?? 0;
      final currency =
          currencyController.text.isNotEmpty ? currencyController.text : 'usd';
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // Step 1: Call Your Backend to Create a PaymentIntent
      final response = await http.post(
        Uri.parse("$shoppingUri/order"), // Update with your backend URL

        headers: {
          'Authorization': "Bearer ${userProvider.user.token}",
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "amount": amount, // Amount in cents (e.g., $10 = 1000)
          "currency": currency,
        }),
      );

      if (response.statusCode == 200) {
        paymentIntent = json.decode(response.body);
        await makePayment();
      } else {
        throw Exception("Failed to create payment intent");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stripe Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (in cents)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: currencyController,
              decoration: InputDecoration(
                labelText: 'Currency (e.g., USD)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: createPaymentIntent,
              child: const Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> initPaymentSheet(context) async {
  try {
    http.Response response = await http.get(
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
    final publishableKey =
        "pk_test_51QUj13KvYI3VPzXg09FJihE8d7S6TZhH1snWgfyn7AcwjQkDX1UMYIyqkeBusWVT7VC8B4jSllmjVfYMmF9knYho00dQKl01Bvyour_publishable_key";

    Stripe.publishableKey = publishableKey;
    BillingDetails billingDetails = const BillingDetails(
      address: Address(
        country: 'IN',
        city: 'Accra',
        line1: 'addr1',
        line2: 'addr2',
        postalCode: '680681',
        state: 'kerala',
        // Other address details
      ),
      // Other billing details
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
      print('success');
    }).onError((error, stackTrace) {
      if (error is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${error.error.localizedMessage}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stripe Error: $error')),
        );
      }
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error initializing payment: $e')),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
}
