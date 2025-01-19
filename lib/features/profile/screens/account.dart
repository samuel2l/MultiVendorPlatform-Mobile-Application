// import 'package:multivendorplatformmobile/constants.dart';
// import 'package:multivendorplatformmobile/features/account/widgets/account_btn.dart';
// import 'package:multivendorplatformmobile/features/account/widgets/orders.dart';
// import 'package:multivendorplatformmobile/providers/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Account extends StatelessWidget {
//   const Account({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserProvider>(context).user;
//     return Scaffold(
//       appBar: PreferredSize(
//         // This widget is used to override the default size of a child widget.
//         preferredSize: const Size.fromHeight(50),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: appBarGradient,
//             ),
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: Image.asset(
//                   'assets/images/multivendorplatformmobile_in.png',
//                   width: 120,
//                   height: 45,
//                   color: Colors.black,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: const Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(right: 15),
//                       child: Icon(Icons.notifications_outlined),
//                     ),
//                     Icon(
//                       Icons.search,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: appBarGradient,
//             ),
//             padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//             child: RichText(
//               text: TextSpan(
//                 text: 'Hello, ${user.name}',
//                 style: const TextStyle(
//                   fontSize: 22,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   AccountButton(
//                     text: 'Orders',
//                     onTap: () {},
//                   ),
//                   AccountButton(
//                     text: 'Sell',
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   AccountButton(
//                       text: 'Logout',
//                       onTap: () => {} //AccountServices().logOut(context),
//                       ),
//                   AccountButton(
//                     text: 'My Wishlist',
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Orders(),
//         ],
//       ),
//     );
//   }
// }
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/profile/widgets/account_btn.dart';
import 'package:multivendorplatformmobile/features/orders/screens/orders.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: appBarGradient),
        ),
        actions: const [
          Icon(Icons.notifications_outlined),
          SizedBox(
            width: 20,
          ),
          Icon(Icons.search),
          SizedBox(
            width: 20,
          ),
        ],
        title: Image.asset(
          'assets/images/multivendorplatformmobile_in.png',
          width: 120,
          height: 45,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 20),
            decoration: const BoxDecoration(gradient: appBarGradient),
            child: Text(
              'Hello, ${user.email}',
              style: const TextStyle(fontSize: 23),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                children: [
                  AccountButton(
                    text: 'Orders',
                    onTap: () {},
                  ),
                  AccountButton(
                    text: 'Sell',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AccountButton(
                    text: 'Orders',
                    onTap: () {},
                  ),
                  AccountButton(
                    text: 'Sell',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Orders(),
        ],
      ),
    );
  }
}
