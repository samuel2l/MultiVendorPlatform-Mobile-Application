import 'package:flutter/material.dart';

// String uri = 'http://<your ip address>:3000';
// String uri = 'https://multivendorapp-user-service.onrender.com';
String uri = "http://localhost:8001";
String productsUri =
    // 'https://multivendorapp-products-microservice.onrender.com';
    'http://localhost:8002';
String shoppingUri =
    // 'https://multivendorplatform-shopping-service.onrender.com';
    'http://localhost:8003';

const Map<String, Color> colorDictionary = {
  "black": Colors.black,
  "white": Colors.white,
  "red": Colors.red,
  "green": Colors.green,
  "blue": Colors.blue,
  "yellow": Colors.yellow,
  "orange": Colors.orange,
  "pink": Colors.pink,
  "purple": Colors.purple,
  "ash": Colors.grey,
  "brown": Colors.brown,
  "cyan": Colors.cyan,
  "amber": Colors.amber,
  "indigo": Colors.indigo,
  "teal": Colors.teal,
  "lime": Colors.lime,
  "deepOrange": Colors.deepOrange,
  "deepPurple": Colors.deepPurple,
  "lightBlue": Colors.lightBlue,
  "lightGreen": Colors.lightGreen,
  "blueGrey": Colors.blueGrey,
};
    const List<Map<String, String>> productCategories = [
  {
    "title": "Electronics",
    "img":"assets/images/electronics.png"
  },
    {
    "title": "Sports and Outdoors",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Home and Kitchen",
    "img":"assets/images/vase.png"
  },
    {
    "title": "Jewelry and Accessories",
    "img":"assets/images/watch.png"
  },
  {
    "title": "Health and Personal Care",
    "img":"assets/images/vase.png"
  },
    {
    "title": "Furniture",
    "img":"assets/images/bed.png"
  },
  {
    "title": "Fashion",
    "img":"assets/images/sports.png"
  },


  {
    "title": "Books and Stationery",
    "img":"assets/images/sports.png"
  },

  {
    "title": "Toys and Games",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Beauty and Cosmetics",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Automotive",
    "img":"assets/images/sports.png"
  },

  {
    "title": "Groceries and Food",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Baby Products",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Pet Supplies",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Tools and Hardware",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Office Supplies",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Musical Instruments",
    "img":"assets/images/sports.png"
  },

  {
    "title": "Art and Craft",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Industrial and Scientific",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Video Games and Consoles",
    "img":"assets/images/sports.png"
  },
  {
    "title": "Music",
    "img":"assets/images/sports.png"
  },
];
const appBarGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 29, 201, 192),
    Color.fromARGB(255, 125, 221, 216),
  ],
  // stops: [0.5, 1.0],
);

const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
const backgroundColor = Colors.white;
const Color greyBackgroundCOlor = Color(0xffebecee);
var selectedNavBarColor = Colors.cyan[800]!;
const unselectedNavBarColor = Colors.black87;

const List<String> carouselImages = [
  'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
  'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
  'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
];

const List<Map<String, String>> categoryImages = [
  {
    'title': 'Mobiles',
    'image': 'assets/images/mobiles.jpeg',
  },
  {
    'title': 'Essentials',
    'image': 'assets/images/essentials.jpeg',
  },
  {
    'title': 'Appliances',
    'image': 'assets/images/appliances.jpeg',
  },
  {
    'title': 'Books',
    'image': 'assets/images/books.jpeg',
  },
  {
    'title': 'Fashion',
    'image': 'assets/images/fashion.jpeg',
  },
];
