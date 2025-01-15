import 'dart:convert';

import 'package:multivendorplatformmobile/features/admin/screens/add_product.dart';
import 'package:multivendorplatformmobile/features/admin/services/admin_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductsSold extends StatefulWidget {
  const ProductsSold({super.key});

  @override
  State<ProductsSold> createState() => _ProductsSoldState();
}

class _ProductsSoldState extends State<ProductsSold> {
  final AdminService adminService = AdminService();
  List? productList = [];

  void getAllProducts() async {
    String res = await adminService.getAllProducts(context);

    for (int item = 0; item < (jsonDecode(res)).length; item++) {
      productList!.add(jsonDecode(res)[item]);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProducts();
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
                  List<String> images = product['images'].cast<String>();
                  return Column(
                    children: [
                      // SizedBox(
                      //   height: 180,
                      //   child: Image.network(
                      //     product['images'][0],
                      //     fit: BoxFit.fitHeight,
                      //   ),
                      // ),
                      CarouselSlider(
                        items: images.map((img) {
                          return Image.network(img);
                        }).toList(),
                        options: CarouselOptions(viewportFraction: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['name'],
                          ),
                          IconButton(
                            onPressed: () {
                              adminService.deleteProduct(
                                  context: context, id: product['_id']);
                            },
                            icon: const Icon(Icons.delete),
                          )
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
