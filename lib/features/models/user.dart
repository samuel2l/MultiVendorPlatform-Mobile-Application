// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:multivendorplatformmobile/features/models/cart_item.dart';
import 'package:multivendorplatformmobile/features/models/profile.dart';

class User {
  final String email;
  final String phone;
  final String role;
  final String token;

  final List<CartItem> cart;
  final List<CartItem> wishlist;
  final List<CartItem> orders;
  final Profile profile;
  User({
    required this.email,
    required this.phone,
    required this.role,
    required this.cart,
    required this.wishlist,
    required this.orders,
    required this.token,
    required this.profile,
  });

  User copyWith(
      {String? email,
      String? password,
      String? phone,
      String? role,
      List<CartItem>? cart,
      List<CartItem>? wishlist,
      List<CartItem>? orders,
      String? token,
      Profile? profile}) {
    return User(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        cart: cart ?? this.cart,
        wishlist: wishlist ?? this.wishlist,
        orders: orders ?? this.orders,
        token: token ?? this.token,
        profile: profile ?? this.profile);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'phone': phone,
      'role': role,
      'cart': cart,
      'wishlist': wishlist,
      'orders': orders,
      'token': token,
      'profile': profile.toMap()
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    print("issue");
    print(map["wishlist"]);
    print("nah");

    print(map["cart"]);
    print("nah");
    print(map["orders"]);
    print("nah");
    return User(
        email: map['email'] as String,
        phone: map['phone'] as String,
        role: map['role'] as String,
        cart: (map['cart'] as List<dynamic>)
            .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
            .toList(),
        wishlist: (map['wishlist'] as List<dynamic>)
            .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
            .toList(),
        orders: (map['cart'] as List<dynamic>)
            .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
            .toList(),
        token: map['token'],
        profile: Profile.fromMap(map['profile'] as Map<String, dynamic>));
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
