// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/models/profile.dart';
import 'package:multivendorplatformmobile/features/products/screens/product_details.dart';
import 'package:multivendorplatformmobile/features/products/services/product_details_service.dart';
import 'package:multivendorplatformmobile/features/search/screens/search_seller_products.dart';
import 'package:multivendorplatformmobile/features/search/widgets/search_field.dart';
import 'package:multivendorplatformmobile/features/search/widgets/searched_product.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key, required this.sellerId});
  final String sellerId;
  static const String routeName = '/view-seller-profile';
  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  ProductDetailsService productDetailsService = ProductDetailsService();
  List<Product>? products;
  Profile? sellerProfile;
  @override
  void initState() {
    // TODO: implement initState
    print("in seller profile init state");
    super.initState();

    gg();
    print("it work????");
  }

  getSellerDetails() async {
    products =
        await productDetailsService.getSellerProducts(context, widget.sellerId);
    print("got profucts?");
    print(products![0].desc);

    sellerProfile =
        await productDetailsService.getSellerProfile(widget.sellerId, context);
    print("got seller profile?");
    print(sellerProfile!.name);
    setState(() {});
  }

  gg() async {
    await getSellerDetails();
  }

  void navigateToSearch(String query) {
    Navigator.of(context).pushNamed(SearchSellerProducts.routeName,
        arguments: {"query": query, "sellerId": widget.sellerId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ListTile(
        trailing: SizedBox(
          child: ClipOval(
            child: Image.network(sellerProfile!.img),
          ),
        ),
        title: Text("${sellerProfile!.name}'s Products ",style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,maxLines: 1,),
      )),
      body: sellerProfile == null || products == null
          ? const Center(
              child: Text('Sometjing went wrong'),
            )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("About us: ${sellerProfile!.about}",style: const TextStyle(fontSize: 19),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("Location: ${sellerProfile!.street},${sellerProfile!.country} "),
                ),
                                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text("Address: ${sellerProfile!.postalCode} "),
                ),
                
                SearchField(onFieldSubmitted: navigateToSearch),
                Expanded(
                    child: ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ProductDetails.routeName,
                            arguments: products![index]);
                      },
                      // child: Container(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 9, vertical: 9),
                      //   padding: const EdgeInsets.all(18),
                      //   color: Colors.grey,
                      //   child: Column(
                      //     children: [
                      //       Text(products![index].name),
                      //       Text(products![index].desc),
                      //     ],
                      //   ),
                      // ),
                      child: SearchedProduct(product: 
                      products![index]
                      ),
                    );
                  },
                ))
              ],
            ),
    );
  }
}
