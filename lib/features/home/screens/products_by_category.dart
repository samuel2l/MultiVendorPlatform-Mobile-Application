import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/home/services/home_service.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>>? productList;
  final HomeService homeService = HomeService();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    try {
      List<dynamic> data = await homeService.getProductsByCategory(
        context: context,
        category: widget.category,
      );

      productList = (data).map((e) => e as Map<String, dynamic>).toList();

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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : productList!.isEmpty
              ? Center(
                  child: Text('We do not have products for ${widget.category}'),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      print(productList!.length);
                      print(productList);
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          print(Product.fromMap(productList![index]));
                          Navigator.pushNamed(
                            context,
                            ProductDetails.routeName,
                            arguments: Product.fromMap(productList![index]),
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product["img"],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                product["name"]!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
