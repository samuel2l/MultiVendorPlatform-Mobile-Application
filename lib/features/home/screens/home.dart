import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/search/screens/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/features/search/widgets/search_field.dart';
import 'package:multivendorplatformmobile/providers/user_provider.dart';
import 'package:multivendorplatformmobile/theme.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void navigateToSearch(String query) {
    Navigator.of(context).pushNamed(Search.routeName, arguments: query);
  }

  int carouselNumber = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

       leading: Container(

       decoration: const BoxDecoration(
        image: DecorationImage(image: 
        AssetImage("assets/images/elogo.png"),
        fit: BoxFit.fitWidth
        )
       ),
       ), 
       title: Text("Welcome ${user.profile.name}"),
      ),
      body: ListView(
        children: [
          SearchField(onFieldSubmitted: navigateToSearch),
         const Padding(
           padding:  EdgeInsets.all(12.0),
           child:  Text("Featured Products",style: TextStyle(fontSize: 24),),
         ),
          Stack(
            children: [
              CarouselSlider(
                items: carouselImages.map((img) {
                  return Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                img,
                              ),

                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  // autoPlay: true,
                  height: 350,
                  // autoPlayInterval: Duration(seconds: 1),
                    viewportFraction: 0.98,
                    onPageChanged: (index, reason) {
                      setState(() {
                        carouselNumber = index;
                      });
                    }),
              ),
              Positioned(
                bottom: 14
                ,
                right: 18,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: white
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < carouselImages.length; i++)
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: carouselNumber == i ? teal : lightAsh),
                              height: 10,
                              width: 10,
                            ),
                          ),
                      ]),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(9),
            child: const Text(
              'Top Products',
              style: TextStyle(fontSize: 20),
            ),
          ),
               CarouselSlider(
                items: carouselImages.map((img) {
                  return Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                img,
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  // autoPlay: true,
                  // autoPlayInterval: Duration(seconds: 1),
                    viewportFraction: 0.98,
                    onPageChanged: (index, reason) {
                      setState(() {
                        carouselNumber = index;
                      });
                    }),
              ),
        ],
      ),
    );
  }
}
