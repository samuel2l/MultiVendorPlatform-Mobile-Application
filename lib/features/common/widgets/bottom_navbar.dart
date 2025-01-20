import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/orders/screens/orders.dart';
import 'package:multivendorplatformmobile/features/home/screens/home.dart';
import 'package:multivendorplatformmobile/features/products/screens/cart.dart';
import 'package:multivendorplatformmobile/features/profile/screens/user_profile.dart';
import 'package:multivendorplatformmobile/features/wishlist/screens/wishlist.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/nav';
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomNavBarBorderWidth = 5;

  List<Widget> pages = [
    const Wishlist(),
    const Orders(),
    const Cart(),
    const UserProfile()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: selectedNavBarColor,
        unselectedItemColor: unselectedNavBarColor,
        backgroundColor: backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0 ? selectedNavBarColor : backgroundColor,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1 ? selectedNavBarColor : backgroundColor,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.heart_broken,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2 ? selectedNavBarColor : backgroundColor,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                    elevation: 0, badgeColor: Colors.white),
                badgeContent: Text(cartLength.toString()),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
                    BottomNavigationBarItem(
            icon: Container(
              width: bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3 ? selectedNavBarColor : backgroundColor,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),

        ],
      ),
    );
  }
}
