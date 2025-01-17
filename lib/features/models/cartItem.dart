// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:multivendorplatformmobile/features/models/product.dart';

class CartItem {
  final Product product;
  final int amount;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'amount': amount,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem({required this.product, required this.amount});
}
