import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    getSellerSales();
  }

  List<Order>? sales;
  getSellerSales() async {
    sales = await sellerService.getSellerSales(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("SALESSS");
    print(sales);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your sales'),
      ),
      body: sales == null
          ? const Center(
              child: CircularProgressIndicator(
                color: teal,
              ),
            )
          : sales!.isEmpty
              ? const Center(
                  child: Text('you have no sales ao'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: sales!.length,
                              itemBuilder: (context, index) {
                                Order order = sales![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return OrderDetails(order: order);
                                      },
                                    ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? lightAsh
                                            : ash),
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Order ID: ${order.orderId}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) {
                                                      return EditDliveryStatus(
                                                          order: order);
                                                      // return EditDliveryStatus();
                                                    },
                                                  ));
                                                },
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: order.status ==
                                                            "received"
                                                        ? Colors.orange
                                                        : order.status ==
                                                                "on the way"
                                                            ? Colors.blue
                                                            : teal,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  order.status,
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            "Date: ${order.date}",
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 0.4,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Total Amount Paid: ${order.amount.toString()}",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
