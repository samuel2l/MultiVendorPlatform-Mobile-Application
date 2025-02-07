import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/search/services/search_service.dart';
import 'package:multivendorplatformmobile/features/search/widgets/search_field.dart';
import 'package:multivendorplatformmobile/features/search/widgets/searched_product.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSellerProducts extends StatefulWidget {
  static const String routeName = '/search-seller-product';
  final String query;
  final String sellerId;

  const SearchSellerProducts(
      {super.key, required this.query, required this.sellerId});

  @override
  State<SearchSellerProducts> createState() => _SearchSellerProductsState();
}

class _SearchSellerProductsState extends State<SearchSellerProducts> {
  List? products;
  final SearchService searchService = SearchService();

  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  getSearchedProduct() async {
    products = await searchService.searchSellerProducts(
        widget.query, widget.sellerId, context);
    print("fetched product");
    print(products);

    setState(() {});
  }

  void navigateToSearch(String query) {
    Navigator.pushNamed(context, SearchSellerProducts.routeName,
        arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(userProvider.user.token);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                userProvider.user.role == 'Seller'
                    ? Seller.routeName
                    : BottomNavBar.routeName, // Route name of the home screen
                (route) => false, // Removes all previous routes
              );
            },
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.home_outlined)),
          )
        ], title: SearchField(onFieldSubmitted: navigateToSearch)),
      ),
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : products!.isEmpty
              ? Center(
                  child: Text('We do not have anything named ${widget.query}'),
                )
              : Column(
                  children: [
                    // const AddressBox(),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetails.routeName,
                                arguments: products![index],
                              );
                            },
                            child: SearchedProduct(
                              product: products![index],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
