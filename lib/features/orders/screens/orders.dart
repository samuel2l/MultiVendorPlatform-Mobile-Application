import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/common/widgets/empty.dart';
import 'package:multivendorplatformmobile/features/models/order.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:multivendorplatformmobile/features/orders/screens/order_details.dart';
import 'package:multivendorplatformmobile/features/orders/services/order_service.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});
  static const String routeName = '/orders';
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  List<Order> ongoingOrders = [];
  List<Order> deliveredOrders = [];

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
    orders = await orderService.getOrders(context: context);
    for (var order in orders!) {
      if (order.status == "received" || order.status == "on the way") {
        ongoingOrders.add(order);
      } else if (order.status == "delivered") {
        deliveredOrders.add(order);
      }
    }

    setState(() {});
  }

  bool isOngoingSelected = true;
  bool isDeliveredSelected = false;
  @override
  Widget build(BuildContext context) {
    User user=Provider.of<UserProvider>(context).user;
    return orders == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,

            title: Text(" ${user.profile.name}'s Orders"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Color(0xFF282828),
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isOngoingSelected = true;
                              isDeliveredSelected = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: isOngoingSelected ? black : null,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14))),
                            child: const Center(
                              child: Text(
                                "Ongoing",
                                style:
                                    TextStyle(color: white, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isOngoingSelected = false;
                              isDeliveredSelected = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: isDeliveredSelected ? black : null,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(14))),
                            child: const Center(
                              child: Text("delivered",
                                  style: TextStyle(
                                      color: white, fontSize: 22)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isOngoingSelected
                    ? ongoingOrders.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.14,
                              ),
                              const Empty(
                                  img: "assets/images/orderempty.png",
                                  title: "No ongoing orders",
                                  subtitle:
                                      "You currently have no ongoing orders. Go shop in our stores for the highest of quality!",
                                  btnText: "Explore Categories"),
                            ],
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: ongoingOrders.length,
                                    itemBuilder: (context, index) {
                                      Order order = ongoingOrders[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return OrderDetails(
                                                  order: order);
                                            },
                                          ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? lightAsh
                                                  : ash),
                                          margin: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerLeft,
                                                child: Text(
                                                  "Order ID: ${order.orderId}",
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4),
                                                  decoration: BoxDecoration(
                                                      color: order.status ==
                                                              "received"
                                                          ? Colors.orange
                                                          : order.status ==
                                                                  "on the way"
                                                              ? Colors.blue
                                                              : teal,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8)),
                                                  child: Text(
                                                    order.status,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  "Date: ${order.date}",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 0.4,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Total Amount Paid: ${order.amount.toString()}",
                                                  style: const TextStyle(
                                                      fontSize: 20),
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
                    : deliveredOrders.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.14,
                              ),
                              const Empty(
                                  img: "assets/images/orderempty.png",
                                  title: "No completed orders",
                                  subtitle:
                                      "You have no completed orders as of Now. Our trusted vendors will surely get your products to you in no time!",
                                  btnText: "Explore Categories"),
                            ],
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: deliveredOrders.length,
                                    itemBuilder: (context, index) {
                                      Order order = deliveredOrders[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return OrderDetails(
                                                  order: order);
                                            },
                                          ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? lightAsh
                                                  : ash),
                                          margin: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerLeft,
                                                child: Text(
                                                  "Order ID: ${order.orderId}",
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          4),
                                                  decoration: BoxDecoration(
                                                      color: order.status ==
                                                              "received"
                                                          ? Colors.orange
                                                          : order.status ==
                                                                  "on the way"
                                                              ? Colors.blue
                                                              : teal,
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8)),
                                                  child: Text(
                                                    order.status,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  "Date: ${order.date}",
                                                  style: const TextStyle(
                                                      fontSize: 17),
                                                ),
                                              ),
                                              const Divider(
                                                thickness: 0.4,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Total Amount Paid: ${order.amount.toString()}",
                                                  style: const TextStyle(
                                                      fontSize: 20),
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
          ),
        );
  }
}
