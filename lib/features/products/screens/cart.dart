import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
import 'package:multivendorplatformmobile/features/products/widgets/cart_product.dart';
import 'package:multivendorplatformmobile/features/search/screens/search.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final ProductDetailsService productDetailsService = ProductDetailsService();

  int quantity = 1;
  void navigateToSearch(String query) {
    Navigator.pushNamed(context, Search.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    // Navigator.pushNamed(
    //   context,
    //   Address.routeName,
    //   arguments: sum.toString(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearch,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search multivendorplatformmobile.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          // const AddressBox(),
          // const CartSubtotal(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('Proceed to Buy (${user.cart.length} items)'),
              onPressed: () => navigateToAddress(sum),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(height: 5),
          ListView.builder(
            itemCount: user.cart.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CartProduct(
                index: index,
              );
            },
          ),
        ],
      ),
    );
  }
}
