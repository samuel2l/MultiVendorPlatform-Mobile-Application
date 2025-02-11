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

class SearchCategoryProduct extends StatefulWidget {
  static const String routeName = '/search-category-product';
  final String query;
  final String category;

  const SearchCategoryProduct(
      {super.key, required this.query, required this.category});

  @override
  State<SearchCategoryProduct> createState() => _SearchCategoryProductState();
}

class _SearchCategoryProductState extends State<SearchCategoryProduct> {
  List? products;
  final SearchService searchService = SearchService();
  bool isAscending = true; // Track sorting order

  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  getSearchedProduct() async {
    products = await searchService.searchProductsInCategory(
        widget.query, widget.category, context);
    setState(() {});
  }

  void sortProducts() {
    if (products != null) {
      products!.sort((a, b) {
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
    Navigator.pushNamed(context, SearchCategoryProduct.routeName,
        arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
      ),
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(
              color: teal,
            ))
          : products!.isEmpty
              ? Center(
                  child: Text('We do not have anything named ${widget.query}'))
              : Column(
                  children: [
                    const SizedBox(height: 10),

                    // Sort Buttona
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sort by Price",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            onPressed: sortProducts,
                            icon: Icon(isAscending
                                ? Icons.arrow_upward
                                : Icons.arrow_downward),
                            label: Text(
                                isAscending ? "Low to High" : "High to Low"),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Product List
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
