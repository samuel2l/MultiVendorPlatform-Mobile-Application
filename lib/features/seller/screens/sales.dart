import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multivendorplatformmobile/features/models/order.dart';
import 'package:multivendorplatformmobile/features/orders/screens/order_details.dart';
import 'package:multivendorplatformmobile/features/seller/screens/edit_dlivery_status.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:multivendorplatformmobile/theme.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});
  static const String routeName = '/seller-sales';

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  SellerService sellerService = SellerService();
  List<Order>? sales;
  bool isAscending = true; // To track sorting order

  @override
  void initState() {
    super.initState();
    getSellerSales();
  }

  getSellerSales() async {
    sales = await sellerService.getSellerSales(context);
    sortSalesByDate(); // Sort initially
    setState(() {});
  }

  // Sorting function
  void sortSalesByDate() {
    if (sales != null) {
      sales!.sort((a, b) {
        DateTime dateA = DateFormat("MMM d, yyyy HH:mm:ss").parse(a.date);
        DateTime dateB = DateFormat("MMM d, yyyy HH:mm:ss").parse(b.date);
        return isAscending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Your sales'),
        actions: [
          IconButton(
            icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
                sortSalesByDate();
              });
            },
          ),
        ],
      ),
      body: sales == null
          ? const Center(
              child: CircularProgressIndicator(color: teal),
            )
          : sales!.isEmpty
              ? const Center(child: Text('You have no sales'))
              : ListView.builder(
                  itemCount: sales!.length,
                  itemBuilder: (context, index) {
                    Order order = sales![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderDetails(order: order),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Theme.of(context).brightness == Brightness.light
                              ? lightAsh
                              : ash,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Order ID: ${order.orderId}",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditDliveryStatus(order: order),
                                      ));
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: order.status == "received"
                                          ? Colors.orange
                                          : order.status == "on the way"
                                              ? Colors.blue
                                              : teal,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      order.status,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Date: ${order.date}",
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            const Divider(thickness: 0.4),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Total Amount Paid: ${order.amount.toString()}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}