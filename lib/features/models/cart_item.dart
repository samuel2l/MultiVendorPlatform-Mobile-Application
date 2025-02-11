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
    print("problem???");
    CartItem testItem = CartItem(
      product: Product(
          id: map['product']["_id"],
          name: map['product']["name"],
          desc: map['product']["desc"],
          img:map['product']["img"]!=null? (map['product']["img"] as List<dynamic>)
              .map((img) => img as String)
              .toList():[],
          type: map['product']["type"],
          stock: int.parse(map['product']['stock']),
          price: map['product']["price"],
          sizes: map['product']['sizes']!=null?(map['product']['sizes'] as List<dynamic>)
              .map((e) => e as String)
              .toList() : [],
          colors:map['product']['colors']!=null?  (map['product']['colors'] as List<dynamic>)
              .map((e) => e as String)
              .toList() : [],
          seller: map['product']["seller"]),
      amount: map['amount'] as int,
    );
    print("IS PROBLEM FROM THE NEWLY ADDED FIELDS?");

    return testItem;
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem({required this.product, required this.amount});
}
