
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
//for old products in db in case we forget to reset db
    if (map['product']['img'] == null || map['product']['stock'] == null) {
      map['product']['img'] = map['product']['desc'] =
          map['product']['type'] = map['product']['seller'] = 'ei';
      map['product']['stock'] = 0;
    }


    CartItem testItem = CartItem(
      product: Product(
          id: map['product']["_id"],
          name: map['product']["name"],
          desc: map['product']["desc"],
          img: map['product']["img"],
          type: map['product']["type"],
          stock: int.parse(map['product']['stock']),
          price: map['product']["price"],
          seller: map['product']["seller"]),
      amount: map['amount'] as int,
    );

    return testItem;
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem({required this.product, required this.amount});
}
