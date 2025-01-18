import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/constants.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      ),
      body: Column(
        children: [
          const Text(
            'Categories ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                // children: [
                //   Container(
                //     decoration: const BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.all(Radius.circular(23))),
                //     child: ListView(
                //       children: [
                //         Image.asset(
                //           "assets/images/Rectangle 43.png",
                //         ),
                //         const Center(
                //             child: Text(
                //           "Electronics",
                //           style: TextStyle(fontSize: 20),
                //         )),

                //       ],
                //     ),
                //   ),
                //    ],
                //                childAspectRatio: 3 / 3.3,
                // crossAxisCount: 2,
                // crossAxisSpacing: 15,
                // mainAxisSpacing: 15,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 3.6,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: productCategories.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(23))),
                    child: ListView(
                      children: [
                        Image.asset(
                          productCategories[index]["img"]!,
                        ),
                         Center(
                            child: Text(
                          productCategories[index]["title"]!,
                          style: TextStyle(fontSize: 20),
                        )),
                      ],
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
