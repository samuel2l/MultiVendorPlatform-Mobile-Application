// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

import 'package:multivendorplatformmobile/features/models/product.dart';

class OrderItem {
  final String orderId;
  final String customerId;
  final double amount;
  final String status;
  final List<Product> items;
  final int amountBought;
  String date;
  OrderItem({
    required this.orderId,
    required this.customerId,
    required this.amount,
    required this.status,
    required this.items,
    required this.amountBought,
    required this.date,
  });

  OrderItem copyWith(
      {String? orderId,
      String? customerId,
      double? amount,
      String? status,
      List<Product>? items,
      int? amountBought,
      String? date}) {
    return OrderItem(
        orderId: orderId ?? this.orderId,
        customerId: customerId ?? this.customerId,
        amount: amount ?? 0,
        status: status ?? this.status,
        items: items ?? this.items,
        amountBought: amountBought ?? 0,
        date: date ?? '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'customerId': customerId,
      'amount': amount,
      'status': status,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    print("inside order item from map");
    print(map);
    int amntBought = 0;
    return OrderItem(
        orderId: map['orderId'] as String,
        customerId: map['customerId'] as String,
        amount: map["amount"].toDouble(),
        status: map['status'] as String,
        items: List<Product>.from(
          (map['items'] as List).map<Product>(
            (x) {
              amntBought = x["amount"];
              //return from api has the amount bought as part of the dict with products
              //amount bought is not part of product class so will be skipped but this property dey need
              //so some manipulation was needed to assign this x["amount"] tothe aount bought of the order class you barb
              return Product.fromMap(x["product"] as Map<String, dynamic>);
            },
          ),
        ),
        amountBought: amntBought,
        date: DateFormat('MMM dd, yyyy HH:mm:ss')
            .format(DateTime.parse(map["createdAt"])));
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItem(orderId: $orderId, customerId: $customerId, amount: $amount, status: $status, items: $items)';
  }

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.customerId == customerId &&
        other.amount == amount &&
        other.status == status &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        customerId.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        items.hashCode;
  }
}
