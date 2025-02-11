import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/home/screens/categories.dart';
import 'package:multivendorplatformmobile/features/products/screens/cart.dart';
import 'package:multivendorplatformmobile/features/profile/screens/account.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller_products.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/wishlist/screens/wishlist.dart';
import 'package:badges/badges.dart' as badges;
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

class Seller extends StatefulWidget {
  const Seller({super.key});
  static const String routeName = '/seller';
  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  int _page = 0;
  double bottomNavBarWidth = 42;
  double bottomNavBarBorderWidth = 5;

  List<Widget> pages = [
    const SellerProducts(),
    const Categories(),
    const Wishlist(),
    const Cart(),
    const Account(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    color: _page == 0
                        ? selectedNavBarColor
                        : Theme.of(context).brightness == Brightness.light
                            ? white
                            : lightAsh,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.shopify,
                color: _page == 0
                    ? teal
                    : Theme.of(context).brightness == Brightness.light
                        ? black
                        : lightAsh,
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
                    color: _page == 1
                        ? selectedNavBarColor
                        : Theme.of(context).brightness == Brightness.light
                            ? white
                            : lightAsh,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.grid_view,
                color: _page == 1
                    ? teal
                    : Theme.of(context).brightness == Brightness.light
                        ? black
                        : lightAsh,
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
                    color: _page == 2
                        ? selectedNavBarColor
                        : Theme.of(context).brightness == Brightness.light
                            ? white
                            : lightAsh,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: teal,
                ),
                badgeContent: Text(
                  Provider.of<UserProvider>(context)
                      .user
                      .wishlist
                      .length
                      .toString(),
                ),
                child: Icon(
                  Icons.favorite_outline,
                  color: _page == 2
                      ? teal
                      : Theme.of(context).brightness == Brightness.light
                          ? black
                          : lightAsh,
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
                    color: _page == 3
                        ? selectedNavBarColor
                        : Theme.of(context).brightness == Brightness.light
                            ? white
                            : lightAsh,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: teal,
                ),
                badgeContent: Text(Provider.of<UserProvider>(context)
                    .user
                    .cart
                    .length
                    .toString()),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: _page == 3
                      ? teal
                      : Theme.of(context).brightness == Brightness.light
                          ? black
                          : lightAsh,
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
                    color: _page == 4
                        ? selectedNavBarColor
                        : Theme.of(context).brightness == Brightness.light
                            ? white
                            : lightAsh,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(
                Icons.person_outlined,
                color: _page == 4
                    ? teal
                    : Theme.of(context).brightness == Brightness.light
                        ? black
                        : lightAsh,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
