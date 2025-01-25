import 'package:multivendorplatformmobile/features/models/profile.dart';
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
      token: '',
      profile: Profile(
          name: '',
          img: '',
          gender: '',
          street: '',
          postalCode: '',
          city: '',
          country: '',
          about: ''));

  User get user => _user;

  void setUserFromModel(User user) {
    _user = user;
    print("set user now ${_user.email}");
    print("set user now ${_user.profile.toString()}");
    notifyListeners();
  }
}
