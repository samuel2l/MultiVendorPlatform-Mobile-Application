// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';
import 'package:multivendorplatformmobile/features/models/order_item_model.dart';

class Order {
  final String orderId;
  final String customerId;
  final double amount;
  final String status;
  final List<OrderItemModel> items;
  String date;
  Order({
    required this.orderId,
    required this.customerId,
    required this.amount,
    required this.status,
    required this.items,
    required this.date,
  });

  Order copyWith(
      {String? orderId,
      String? customerId,
      double? amount,
      String? status,
      List<OrderItemModel>? items,
      int? amountBought,
      String? date}) {
    return Order(
        orderId: orderId ?? this.orderId,
        customerId: customerId ?? this.customerId,
        amount: amount ?? 0,
        status: status ?? this.status,
        items: items ?? this.items,
        date: date ?? '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'customerId': customerId,
      'amount': amount,
      'status': status,
      'items': items.map((x) => x.toMap()).toList(),
      'date': date
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['orderId'] as String,
      customerId: map['customerId'] as String,
      amount: map["amount"]!=null?map["amount"].toDouble():map["totalAmount"].toDouble(),
      status: map['status'] as String,
      items: List<OrderItemModel>.from(
        (map['items'] as List).map<OrderItemModel>(
          (x) {
            print("X TO SEE IF IT HAS AMOUTN???????");
            print(x);
            print(x["amount"]);
            print("nada>>>>????????");

            return OrderItemModel.fromMap(x as Map<String, dynamic>);
          },
        ),
      ),
      date: DateFormat('MMM dd, yyyy HH:mm:ss').format(
        DateTime.parse(map["createdAt"]),
      ),
    );
  }
}
