// ignore_for_file: use_build_context_synchronously

import 'package:multivendorplatformmobile/features/home/services/home_service.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/search/screens/search_category_product.dart';
import 'package:multivendorplatformmobile/features/search/widgets/search_field.dart';
import 'package:multivendorplatformmobile/features/search/widgets/searched_product.dart';
import 'package:multivendorplatformmobile/utils.dart';

class ProductsByCategory extends StatefulWidget {
  static const String routeName = '/product-category';
  final String category;
  const ProductsByCategory({
    super.key,
    required this.category,
  });

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  void navigateToSearch(String query) {
    Navigator.of(context).pushNamed(SearchCategoryProduct.routeName,
        arguments: {"query": query, "category": widget.category});
  }

  List<Product>? products;
  fetchCategoryProducts() async {
    try {
      products = await homeService.getProductsByCategory(
        context: context,
        category: widget.category,
      );
      print("gotten data?");
      print(products);

      setState(() {});
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Text(
            widget.category,
          ),
        ),
      ),
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : products!.isEmpty
              ? Center(
                  child: Text('We do not have products for ${widget.category}'),
                )
              : Column(
                children: [
                  SearchField(onFieldSubmitted: navigateToSearch),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        print(products!.length);
                        print(products);
                        final product = products![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetails.routeName,
                                arguments: products![index],
                              );
                            },
                            child: SearchedProduct(product: product));
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
