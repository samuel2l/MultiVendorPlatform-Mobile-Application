import 'dart:convert';

import 'package:multivendorplatformmobile/features/seller/screens/add_product.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/utils.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts({super.key});
  static const String routeName = 'seller-products';
  @override
  State<SellerProducts> createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  final SellerService sellerService = SellerService();
  List? productList = [];

  void getSellerProducts() async {
    try {
      String res = await sellerService.getSellerProducts(context);

      for (int item = 0; item < (jsonDecode(res)).length; item++) {
        productList!.add(jsonDecode(res)[item]);
      }
      setState(() {});
    } catch (e) {
      showSnackBar(context, 'something went wrong');
    }
  }

  @override
  void initState() {
    super.initState();
    getSellerProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return productList == null
        // this is why we make product list nullable. so we can use a circular progress
        //cos if there are no products it means the circular will show sahn
        //but if nullable it will be initially null and if empty then it will be []
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.routeName);
              },
              shape: const CircleBorder(),
              tooltip: 'Add New product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: productList!.length,
                itemBuilder: (context, index) {
                  var product = productList![index];
                  print("ERROR PART");
                  print(product["img"]);
                  String images = product['img'];
                  return Column(
                    children: [
                      // SizedBox(
                      //   height: 180,
                      //   child: Image.network(
                      //     product['images'][0],
                      //     fit: BoxFit.fitHeight,
                      //   ),
                      // ),
                      // CarouselSlider(
                      //   items: images.map((img) {
                      //     return Image.network(img);
                      //   }).toList(),
                      //   options: CarouselOptions(viewportFraction: 1),
                      // ),
                      Image.network(
                        images,
                        height: 150,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['name'],
                          ),
                          IconButton(
                            onPressed: () {
                              sellerService.deleteProduct(
                                  context: context, id: product['_id']);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }
}
