// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String id;

  final String name;
  final String desc;
  final List<String> img;
  final String type;
  final int stock;
  final dynamic price;
  final List<String> sizes;
  final List<String> colors;

  final String seller;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.img,
    required this.type,
    required this.stock,
    required this.price,
    required this.sizes,
    required this.colors,
    required this.seller,
  });

  Product copyWith({
    String? id,
    String? name,
    String? desc,
    List<String>? img,
    String? type,
    int? stock,
    dynamic price,
    List<String>? sizes,

    List<String>? colors,
    
    String? seller,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      img: img ??this.img,
      type: type ?? this.type,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      sizes: sizes??this.sizes,
      colors: colors??this.colors,
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
      'sizes': sizes,
      'colors': colors,
      'seller': seller,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      name: map['name'] as String,
      desc: map['desc'] as String,
      img: (map['img'] as List<dynamic>)
          .map((img) => img.toString())
          .toList(),
      type: map['type'] as String,
      stock: map['stock'] as int,
      price: map['price'] as dynamic,
      sizes: (map['sizes'] as List<dynamic>)
          .map((size) => size.toString())
          .toList(),
      colors: (map['colors'] as List<dynamic>)
          .map((color) => color.toString())
          .toList(),
      seller: map['seller'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
