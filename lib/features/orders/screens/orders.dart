import 'package:multivendorplatformmobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/models/order_item.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/orders/services/order_service.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderItem>? orders;
  final OrderService orderService = OrderService();
  List<String> imgs = [
    'assets/images/appliances.jpeg',
    'assets/images/appliances.jpeg',
    'assets/images/appliances.jpeg',
    'assets/images/appliances.jpeg',
  ];
  @override
  void initState() {
    super.initState();
    fetchOrders(context);
  }

  void fetchOrders(context) async {
    // orders = await accountServices.fetchMyOrders(context: context);
    orders = await orderService.getOrders(context: context);
    print("from fetch orders?????");
    print(orders);

    // print(orders![0].);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: Text("errorrrr"),
          )
        : orders!.isEmpty
            ? const Center(
                child: Text("you have bo orders"),
              )
            : Scaffold(
                appBar: AppBar(),
                body: Column(
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
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          OrderItem order = orders![index];

                          return Container(
                            height: 450,
                            color: Colors.grey,
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          order.orderId,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          '\$${order.amount}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          '\$${order.date}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 220,
                                        child: ListView.builder(
                                          itemCount: order.items.length,
                                          itemBuilder: (context, index) {
                                            Product product =
                                                order.items[index];
                                            return Column(
                                              children: [
                                                Text(product.desc),
                                                Text(product.name),
                                                Text(order.amountBought
                                                    .toString()),
                                                Text(product.type),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 235,
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: Text(
                                          order.status,
                                          style: const TextStyle(
                                            color: Colors.teal,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
  }
}
