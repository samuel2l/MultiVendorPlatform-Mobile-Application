// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String name;
  final dynamic price;
  final String description;
  final int stock;
  final String? id;
  final String category;
  final List<String> images;
  final List<Map<String, dynamic>> ratings;
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'description': description,
      'stock': stock,
      'id': id,
      'category': category,
      'images': images,
      'ratings': ratings,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: (map['name']??'') as String,
      price: (map['price'] ?? 0).toDouble(),
      description: (map['description']??'') as String,
      stock: (map['stock']??0) as int,
      id: map['_id'] != null ? map['_id'] as String : null,
      category: (map['category']??'') as String,
      images: List<String>.from((map['images']??[]) as List<dynamic>),
      ratings: map['ratings'] != null
          ? List<Map<String, dynamic>>.from(map['ratings'] as List<dynamic>)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      price: json['price'],
      description: json['description'] as String,
      stock: json['stock'] as int,
      id: json['_id'] as String?,
      category: json['category'] as String,
      images: List<String>.from(json['images'] as List<dynamic>),
      ratings: json['ratings'] != null
          ? List<Map<String, dynamic>>.from(json['ratings'] as List<dynamic>)
          : [],
    );
  }

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.category,
    required this.images,
    this.id,
    this.ratings = const [],
  });
}
