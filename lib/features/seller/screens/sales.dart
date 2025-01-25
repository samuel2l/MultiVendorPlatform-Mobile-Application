import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/models/order_item.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:multivendorplatformmobile/features/seller/widgets/sale.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

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

  List<OrderItem>? sales;
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
              child: Text('you have no sales ao'),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: sales!.length,
                  itemBuilder: (context, index) {
                    return Sale(order: sales![index]);
                  },
                ))
              ],
            ),
    );
  }
}
