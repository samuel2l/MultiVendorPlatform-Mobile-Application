import 'package:multivendorplatformmobile/constants.dart';

import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/search/services/search_service.dart';
import 'package:multivendorplatformmobile/features/search/widgets/searched_product.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    getSearchedProduct();
  }

  getSearchedProduct() async {
    products = await searchService.searchProductsInCategory(
        widget.query, widget.category, context);
    print("fetched product");
    print(products);

    setState(() {});
  }

  void navigateToSearch(String query) {
    Navigator.pushNamed(context, SearchCategoryProduct.routeName,
        arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(userProvider.user.token);

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
