import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/home/screens/categories.dart';
import 'package:multivendorplatformmobile/features/orders/screens/orders.dart';
import 'package:multivendorplatformmobile/features/products/screens/cart.dart';
import 'package:multivendorplatformmobile/features/seller/screens/sales.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller_products.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/wishlist/screens/wishlist.dart';

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
    const Cart(),
    // const Wishlist(),
    const Categories(),
    const Orders(),
    const Sales()
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
          // ACCOUNT
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
                Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),
          // CART
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
              // child: Badge(
              //   // elevation: 0,
              //   // badgeContent: Text(userCartLen.toString()),
              //   // badgeColor: Colors.white,

              //   child: const Icon(
              //     Icons.shopping_cart_outlined,
              //   ),
              // ),
              child: const Icon(
                Icons.receipt_outlined,
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
                Icons.shopping_cart_outlined,
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
                    color: _page == 4 ? selectedNavBarColor : backgroundColor,
                    width: bottomNavBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
