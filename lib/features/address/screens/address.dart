import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/address/services/address_service.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Address extends StatefulWidget {
  static const String routeName = '/address';
  
  const Address({
    super.key,

  });

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final TextEditingController addressController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  // List<PaymentItem> paymentItems = [];
  final AddressService addressService = AddressService();

  @override
  void initState() {
    super.initState();
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount,
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  // void onApplePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressService.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressService.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     totalSum: double.parse(widget.totalAmount),
  //   );
  // }

  // void onGooglePayResult(res) {
  //   if (Provider.of<UserProvider>(context, listen: false)
  //       .user
  //       .address
  //       .isEmpty) {
  //     addressService.saveUserAddress(
  //         context: context, address: addressToBeUsed);
  //   }
  //   addressService.placeOrder(
  //     context: context,
  //     address: addressToBeUsed,
  //     // totalSum: double.parse(widget.totalAmount),
  //   );
  // }
  void submitAddress() {
    addressService.placeOrder(
        context: context);
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    // bool isForm = flatBuildingController.text.isNotEmpty ||
    //     areaController.text.isNotEmpty ||
    //     pincodeController.text.isNotEmpty ||
    //     addressController.text.isNotEmpty;

    // if (isForm) {
    //   if (_addressFormKey.currentState!.validate()) {
    //     addressToBeUsed =
    //         '${flatBuildingController.text}, ${areaController.text}, ${addressController.text} - ${pincodeController.text}';
    //   } else {
    //     throw Exception('Please enter all the values!');
    //   }
    // } else if (addressFromProvider.isNotEmpty) {
    //   addressToBeUsed = addressFromProvider;
    // } else {
    //   showSnackBar(context, 'ERROR');
    // }
  }

  @override
  Widget build(BuildContext context) {
    var address = '';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                        hintText: 'Enter the delivery address if new'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Check if the form is valid
                      if (_addressFormKey.currentState!.validate()) {
                        // Call your API function here
                        submitAddress();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            // ApplePayButton(
            //   width: double.infinity,
            //   style: ApplePayButtonStyle.whiteOutline,
            //   type: ApplePayButtonType.buy,
            //   // paymentConfigurationAsset: 'applepay.json',
            //   onPaymentResult: onApplePayResult,
            //   paymentItems: paymentItems,
            //   margin: const EdgeInsets.only(top: 15),
            //   height: 50,
            //   onPressed: () => payPressed(address), paymentConfiguration: null,
            // ),
            // const SizedBox(height: 10),
            // GooglePayButton(
            //   onPressed: () => payPressed(address),
            //   // paymentConfigurationAsset: 'gpay.json',
            //   onPaymentResult: onGooglePayResult,
            //   paymentItems: paymentItems,
            //   height: 50,
            //   // style: GooglePayButtonStyle.black,
            //   type: GooglePayButtonType.buy,
            //   margin: const EdgeInsets.only(top: 15),
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ), paymentConfiguration: null,
            // ),
          ],
        ),
      ),
    );
  }
}
