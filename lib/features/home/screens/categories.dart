import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/home/screens/products_by_category.dart';
import 'package:multivendorplatformmobile/features/search/screens/search.dart';
import 'package:multivendorplatformmobile/features/search/widgets/search_field.dart';
import 'package:multivendorplatformmobile/theme.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void navigateToSearch(String query) {
    Navigator.of(context).pushNamed(Search.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
          elevation: 0, title: SearchField(onFieldSubmitted: navigateToSearch)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Categories ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 3.6,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: productCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ProductsByCategory.routeName, arguments: {
                        "category": productCategories[index]["title"]!
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? white
                                  : ash,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23),),),
                      child: ListView(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                image: DecorationImage(
                                    image: AssetImage(
                                      productCategories[index]["img"]!,
                                    ),
                                    fit: BoxFit.fitHeight)),
                          ),
                          Center(
                              child: Text(
                            productCategories[index]["title"]!,
                            style: const TextStyle(
                                fontSize: 18, overflow: TextOverflow.ellipsis),
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
