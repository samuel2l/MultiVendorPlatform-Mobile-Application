import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/account/widgets/product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // List<Order>? orders;
  // final AccountServices accountServices = AccountServices();
List<String> imgs=[
'assets/images/appliances.jpeg',
'assets/images/appliances.jpeg',
'assets/images/appliances.jpeg',
'assets/images/appliances.jpeg',

];
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    // orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imgs.length,
                  itemBuilder: (context, index) {
                    return Product(image:imgs[index]);
                  },
                ),
              ),
            ],
          );
  }
}