// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String id;

  final String name;
  final String desc;
  final String img;
  final String type;
  final int stock;
  final dynamic price;
  final String seller;
  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.img,
    required this.type,
    required this.stock,
    required this.price,
    required this.seller,
  });

  Product copyWith({
    String? id,
    String? name,
    String? desc,
    String? img,
    String? type,
    int? stock,
    dynamic price,
    String? seller,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      img: img ?? this.img,
      type: type ?? this.type,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      seller: seller ?? this.seller,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'img': img,
      'type': type,
      'stock': stock,
      'price': price,
      'seller': seller,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    print("insdie product from map");
    print(map);


    return Product(
      id: map['_id'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
      img: map['img'] as String,
      type: map['type'] as String,
      stock: map['stock'] as int,
      price: map['price'] as dynamic,
      seller: map['seller'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
