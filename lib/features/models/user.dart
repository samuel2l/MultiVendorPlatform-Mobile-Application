// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:multivendorplatformmobile/features/models/cartItem.dart';
import 'package:multivendorplatformmobile/features/models/profile.dart';

class User {
  final String email;
  final String password;
  final String phone;
  final String role;
  final Profile profile;


  final List<CartItem> cart;
  final List<CartItem> wishlist;

  final List<CartItem> orders;
  final String token;
  User({
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.profile,
    required this.cart,
    required this.wishlist,
    required this.orders,
    required this.token,
  });
  
  

  User copyWith({
    String? email,
    String? password,
    String? phone,
    String? role,
    Profile? profile,
    List<CartItem>? cart,
    List<CartItem>? wishlist,
    List<CartItem>? orders,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profile: profile ?? this.profile,
      cart: cart ?? this.cart,
      wishlist: wishlist ?? this.wishlist,
      orders: orders ?? this.orders,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      'profile': profile.toMap(),
      'cart': cart.map((x) => x.toMap()).toList(),
      'wishlist': wishlist.map((x) => x.toMap()).toList(),
      'orders': orders.map((x) => x.toMap()).toList(),
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      profile: Profile.fromMap(map['profile'] as Map<String,dynamic>),
      cart: List<CartItem>.from((map['cart'] as List<int>).map<CartItem>((x) => CartItem.fromMap(x as Map<String,dynamic>),),),
      wishlist: List<CartItem>.from((map['wishlist'] as List<int>).map<CartItem>((x) => CartItem.fromMap(x as Map<String,dynamic>),),),
      orders: List<CartItem>.from((map['orders'] as List<int>).map<CartItem>((x) => CartItem.fromMap(x as Map<String,dynamic>),),),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(email: $email, password: $password, phone: $phone, role: $role, profile: $profile, cart: $cart, wishlist: $wishlist, orders: $orders, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.phone == phone &&
      other.role == role &&
      other.profile == profile &&
      listEquals(other.cart, cart) &&
      listEquals(other.wishlist, wishlist) &&
      listEquals(other.orders, orders) &&
      other.token == token;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      role.hashCode ^
      profile.hashCode ^
      cart.hashCode ^
      wishlist.hashCode ^
      orders.hashCode ^
      token.hashCode;
  }
}
