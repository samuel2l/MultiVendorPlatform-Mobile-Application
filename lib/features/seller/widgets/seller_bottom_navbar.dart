// import 'package:flutter/material.dart';
// import 'package:multivendorplatformmobile/constants.dart';
// import 'package:multivendorplatformmobile/features/home/screens/categories.dart';
// import 'package:multivendorplatformmobile/features/orders/screens/orders.dart';
// import 'package:multivendorplatformmobile/features/products/screens/cart.dart';
// import 'package:multivendorplatformmobile/features/seller/screens/sales.dart';
// import 'package:multivendorplatformmobile/features/seller/screens/seller_products.dart';
// import 'package:multivendorplatformmobile/providers/user_provider.dart';
// import 'package:multivendorplatformmobile/theme.dart';
// import 'package:badges/badges.dart' as badges;
// import 'package:provider/provider.dart';

// class SellerBottomNavbar extends StatefulWidget {
//   const SellerBottomNavbar({super.key});

//   @override
//   State<SellerBottomNavbar> createState() => _SellerBottomNavbarState();
// }

// class _SellerBottomNavbarState extends State<SellerBottomNavbar> {
//   int _page = 0;
//   double bottomNavBarWidth = 42;
//   double bottomNavBarBorderWidth = 5;

//   List<Widget> pages = [
//     const SellerProducts(),
//     const Cart(),
//     const Categories(),
//     const Orders(),
//     const Sales()
//   ];

//   void updatePage(int page) {
//     setState(() {
//       _page = page;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _page,
//       selectedItemColor: selectedNavBarColor,
//       unselectedItemColor: unselectedNavBarColor,
//       backgroundColor: backgroundColor,
//       iconSize: 28,
//       onTap: updatePage,
//       items: [
//         BottomNavigationBarItem(
//           icon: Container(
//             width: bottomNavBarWidth,
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                   color: _page == 0
//                       ? selectedNavBarColor
//                       : Theme.of(context).brightness == Brightness.light
//                           ? white
//                           : lightAsh,
//                   width: bottomNavBarBorderWidth,
//                 ),
//               ),
//             ),
//             child: Icon(
//               Icons.home_outlined,
//               color: _page == 0
//                   ? teal
//                   : Theme.of(context).brightness == Brightness.light
//                       ? black
//                       : lightAsh,
//             ),
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Container(
//             width: bottomNavBarWidth,
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                   color: _page == 1
//                       ? selectedNavBarColor
//                       : Theme.of(context).brightness == Brightness.light
//                           ? white
//                           : lightAsh,
//                   width: bottomNavBarBorderWidth,
//                 ),
//               ),
//             ),
//             child: Icon(
//               Icons.analytics_outlined,
//               color: _page == 1
//                   ? teal
//                   : Theme.of(context).brightness == Brightness.light
//                       ? black
//                       : lightAsh,
//             ),
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Container(
//             width: bottomNavBarWidth,
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                   color: _page == 2
//                       ? selectedNavBarColor
//                       : Theme.of(context).brightness == Brightness.light
//                           ? white
//                           : lightAsh,
//                   width: bottomNavBarBorderWidth,
//                 ),
//               ),
//             ),
//             child: badges.Badge(
//               badgeStyle: const badges.BadgeStyle(
                
//                 badgeColor: teal,
//               ),
//               badgeContent: Text(Provider.of<UserProvider>(context)
//                   .user
//                   .cart
//                   .length
//                   .toString()),
//               child: Icon(
//                 Icons.shopping_cart_outlined,
//                 color: _page == 2
//                     ? teal
//                     : Theme.of(context).brightness == Brightness.light
//                         ? black
//                         : lightAsh,
//               ),
//             ),
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Container(
//             width: bottomNavBarWidth,
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                     color: _page == 3
//                         ? selectedNavBarColor
//                         : Theme.of(context).brightness == Brightness.light
//                             ? white
//                             : lightAsh,
//                   width: bottomNavBarBorderWidth,
//                 ),
//               ),
//             ),
//             child: Icon(
//               Icons.shopping_cart_outlined,
//               color: _page == 3
//                   ? teal
//                   : Theme.of(context).brightness == Brightness.light
//                       ? black
//                       : lightAsh,
//             ),
//           ),
//           label: '',
//         ),
//         BottomNavigationBarItem(
//           icon: Container(
//             width: bottomNavBarWidth,
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                     color: _page == 4
//                         ? selectedNavBarColor
//                         : Theme.of(context).brightness == Brightness.light
//                             ? white
//                             : lightAsh,
//                   width: bottomNavBarBorderWidth,
//                 ),
//               ),
//             ),
//             child: Icon(
//               Icons.analytics_outlined,
//               color: _page == 4
//                   ? teal
//                   : Theme.of(context).brightness == Brightness.light
//                       ? black
//                       : lightAsh,
//             ),
//           ),
//           label: '',
//         ),
//       ],
//     );
//   }
// }
