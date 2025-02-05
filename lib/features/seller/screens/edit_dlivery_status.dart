// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/models/order.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:multivendorplatformmobile/features/seller/widgets/seller_bottom_navbar.dart';

class EditDliveryStatus extends StatefulWidget {
  const EditDliveryStatus({super.key, required this.order});
  final Order order;
  static const String routeName = '/edit-delivery';
  @override
  State<EditDliveryStatus> createState() => _EditDliveryStatusState();
}

class _EditDliveryStatusState extends State<EditDliveryStatus> {
  ProductDetailsService productDetailsService = ProductDetailsService();
  SellerService sellerService = SellerService();
  String selectedStatus = '';
  @override
  void initState() {
    // TODO: implement initState
    selectedStatus = widget.order.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SellerBottomNavbar(),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Current order status: ${widget.order.status}",
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 40,
            ),
            DropdownButton<String>(
              value: selectedStatus,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                }
              },
              items: ["on the way", "delivered", "received"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              style: const TextStyle(fontSize: 17, color: Colors.black),
              dropdownColor: Colors.white,
              underline: Container(height: 0), // Removes the default underline
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
                onPressed: () {
                  sellerService.updateDeliveryStatus(
                      context, widget.order.orderId, selectedStatus);
                },
                child: const Text("Edit status"))
          ],
        ),
      ),
    );
  }
}
