import 'package:multivendorplatformmobile/features/models/profile.dart';
import 'package:multivendorplatformmobile/features/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(email: '', password: '', phone: '', role: '', profile: Profile(name: '', gender: '', street: '', postalCode: '', city: '', country: ''), cart: [], wishlist: [], orders: [], token: '');

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}