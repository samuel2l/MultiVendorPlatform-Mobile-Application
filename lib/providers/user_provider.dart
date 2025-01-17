import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      email: '',
      phone: '',
      role: '',
      cart: [],
      wishlist: [],
      orders: [],
      token: '');

  User get user => _user;

  void setUserFromModel(User user) {
    _user = user;
    print("set user now ${_user.email}");
    notifyListeners();
  }
}
