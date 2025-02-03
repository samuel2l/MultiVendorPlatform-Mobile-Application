// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:multivendorplatformmobile/features/models/product.dart';

class OrderItemModel {
  final Product product;
  final int amountBought;
  OrderItemModel({
    required this.product,
    required this.amountBought,
  });
  


  OrderItemModel copyWith({
    Product? product,
    int? amountBought,
  }) {
    return OrderItemModel(
      product: product ?? this.product,
      amountBought: amountBought ?? this.amountBought,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'amountBought': amountBought,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      product: Product.fromMap(map['product'] as Map<String,dynamic>),
      amountBought: map['amount'] as int,
    );
  }

}
