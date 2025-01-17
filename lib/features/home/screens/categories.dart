import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 238, 238, 238),
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
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [
                  Container(

                    decoration:const BoxDecoration(
                                          color: Colors.white,


                      borderRadius: BorderRadius.all(Radius.circular(23))
                    ),
                    child: ListView(
                      children: [
                        Image.asset("assets/images/Rectangle 43.png",height: 160,width: 240,),
                        
                       const Center(child:  Text("Electronics",style: TextStyle(fontSize: 20),))
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 36.png",height: 160,),
                        const Text("Electronics",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/music.png",
                        height: 100,
                        ),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Image.asset("assets/images/Rectangle 42.png"),
                        const Text("Electronics")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
