import 'package:multivendorplatformmobile/features/common/widgets/bottom_navbar.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/search/services/search_service.dart';
import 'package:multivendorplatformmobile/features/search/widgets/search_field.dart';
import 'package:multivendorplatformmobile/features/search/widgets/searched_product.dart';
import 'package:multivendorplatformmobile/features/seller/screens/seller.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search-product';
  final String query;

  const Search({super.key, required this.query});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List? products;
  final SearchService searchService = SearchService();
  bool isAscending = true; // Sorting order flag

  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  getSearchedProduct() async {
    products = await searchService.getProducts(widget.query, context);
    print("Fetched products:");
    print(products);

    setState(() {});
  }

  void sortProducts() {
    if (products != null) {
      products!.sort((a, b) {
        print("an b");
        print(a);
        print(a.price.runtimeType);
        print(b);
        double priceA = a.price.toDouble();
        double priceB = b.price.toDouble();
        return isAscending
            ? priceA.compareTo(priceB)
            : priceB.compareTo(priceA);
      });

      isAscending = !isAscending; // Toggle sort order
      setState(() {});
    }
  }

  void navigateToSearch(String query) {
    Navigator.pushNamed(context, Search.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(userProvider.user.token);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                userProvider.user.role == 'Seller'
                    ? Seller.routeName
                    : BottomNavBar.routeName,
                (route) => false,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.home_outlined),
            ),
          ),
        ],
        title: SearchField(onFieldSubmitted: navigateToSearch),
      ),
      body: products == null
          ? const Center(child: CircularProgressIndicator(color: teal,))
          : products!.isEmpty
              ? Center(
                  child: Text('We do not have anything named ${widget.query}'),
                )
              : Column(
                  children: [
                    const SizedBox(height: 10),

                    // Sort Button
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton.icon(
                        onPressed: sortProducts,
                        icon: Icon(isAscending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                        label: Text(isAscending
                            ? "Sort: Low to High"
                            : "Sort: High to Low"),
                      ),
                    ),

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
