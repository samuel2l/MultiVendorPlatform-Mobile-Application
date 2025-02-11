import 'package:flutter/material.dart';

// String uri = 'http://<your ip address>:3000';
// String uri = 'https://multivendorapp-user-service.onrender.com';

String uri = "http://192.168.97.11:8001";
String productsUri =
    // 'https://multivendorapp-products-microservice.onrender.com';
    'http://192.168.97.11:8002';
String shoppingUri =
    // 'https://multivendorplatform-shopping-service.onrender.com';
    'http://192.168.97.11:8003';

class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Quality Products',
      image: 'assets/images/eonb1.png',
      description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
  OnboardingContent(
      title: 'Make Payments',
      image: 'assets/images/eonb2.png',
      description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
  OnboardingContent(
      title: 'Get your order',
      image: 'assets/images/eonb3.png',
      description:
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit."),
];

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
  "teal": Color(0xFF008080),
  "lime": Colors.lime,
  "deepOrange": Colors.deepOrange,
  "deepPurple": Colors.deepPurple,
  "lightBlue": Colors.lightBlue,
  "lightGreen": Colors.lightGreen,
  "blueGrey": Colors.blueGrey,
};
Map<String, String> sizeMapping = {
  "US 1 / UK 13 / EU 29": "UK 13",
  "US 1.5 / UK 13.5 / EU 30": "UK 13.5",
  "US 2 / UK 1 / EU 31": "UK 1",
  "US 2.5 / UK 1.5 / EU 31.5": "UK 1.5",
  "US 3 / UK 2 / EU 32": "UK 2",
  "US 3.5 / UK 2.5 / EU 33": "UK 2.5",
  "US 4 / UK 3 / EU 34": "UK 3",
  "US 4.5 / UK 3.5 / EU 35": "UK 3.5",
  "US 5 / UK 3 / EU 36": "UK 3",
  "US 5.5 / UK 3.5 / EU 36.5": "UK 3.5",
  "US 6 / UK 4 / EU 37": "UK 4",
  "US 6.5 / UK 4.5 / EU 37.5": "UK 4.5",
  "US 7 / UK 5 / EU 38": "UK 5",
  "US 7.5 / UK 5.5 / EU 38.5": "UK 5.5",
  "US 8 / UK 6 / EU 39": "UK 6",
  "US 8.5 / UK 6.5 / EU 40": "UK 6.5",
  "US 9 / UK 7 / EU 40.5": "UK 7",
  "US 9.5 / UK 7.5 / EU 41": "UK 7.5",
  "US 10 / UK 8 / EU 42": "UK 8",
  "US 10.5 / UK 8.5 / EU 42.5": "UK 8.5",
  "US 11 / UK 9 / EU 43": "UK 9",
  "US 11.5 / UK 9.5 / EU 44": "UK 9.5",
  "US 12 / UK 10 / EU 44.5": "UK 10",
  "US 13 / UK 11 / EU 46": "UK 11",
  "XS": "UK XS",
  "S": "UK S",
  "M": "UK M",
  "L": "UK L",
  "XL": "UK XL",
  "XXL": "UK XXL"
};
const List<String> colors = [
  "Red",
  "Blue",
  "Green",
  "Yellow",
  "Orange",
  "Purple",
  "Pink",
  "Black",
  "White",
  "Gray",
  "Brown",
  "Cyan",
  "Magenta",
];
const List<String> sizes = [

  "US 1 / UK 13 / EU 29",
  "US 1.5 / UK 13.5 / EU 30",
  "US 2 / UK 1 / EU 31",
  "US 2.5 / UK 1.5 / EU 31.5",
  "US 3 / UK 2 / EU 32",
  "US 3.5 / UK 2.5 / EU 33",
  "US 4 / UK 3 / EU 34",
  "US 4.5 / UK 3.5 / EU 35",
  "US 5 / UK 3 / EU 36",
  "US 5.5 / UK 3.5 / EU 36.5",
  "US 6 / UK 4 / EU 37",
  "US 6.5 / UK 4.5 / EU 37.5",
  "US 7 / UK 5 / EU 38",
  "US 7.5 / UK 5.5 / EU 38.5",
  "US 8 / UK 6 / EU 39",
  "US 8.5 / UK 6.5 / EU 40",
  "US 9 / UK 7 / EU 40.5",
  "US 9.5 / UK 7.5 / EU 41",
  "US 10 / UK 8 / EU 42",
  "US 10.5 / UK 8.5 / EU 42.5",
  "US 11 / UK 9 / EU 43",
  "US 11.5 / UK 9.5 / EU 44",
  "US 12 / UK 10 / EU 44.5",
  "US 13 / UK 11 / EU 46",
  "XS",
  "S",
  "M",
  "L",
  "XL",
  "XXL",
];

const List<Map<String, String>> productCategories = [
  {"title": "Electronics", "img": "assets/images/electronics.png"},
  {"title": "Sports ", "img": "assets/images/sports.png"},
  {"title": "Jewelry and Accessories", "img": "assets/images/jewell.webp"},
  {"title": "Beauty and Cosmetics", "img": "assets/images/kylie.png"},
  {"title": "Musical Instruments", "img": "assets/images/piano.jpg"},
  {"title": "Industry and Science", "img": "assets/images/sc.jpg"},
  {"title": "Home and Kitchen", "img": "assets/images/vase.png"},
  {"title": "Health and Personal Care", "img": "assets/images/health.webp"},
  {"title": "Furniture", "img": "assets/images/bed.png"},
  {"title": "Fashion", "img": "assets/images/fashion.jpg"},
  {"title": "Books and Stationery", "img": "assets/images/books.jpg"},
  {"title": "Toys and Games", "img": "assets/images/games.webp"},
  {"title": "Automotive", "img": "assets/images/automotive.webp"},
  {"title": "Groceries and Food", "img": "assets/images/groc.webp"},
  {"title": "Baby Products", "img": "assets/images/sports.png"},
  {"title": "Pet Supplies", "img": "assets/images/pet.jpg"},
  {"title": "Tools and Hardware", "img": "assets/images/tools.jpg"},
  {"title": "Office Supplies", "img": "assets/images/office.jpg"},
  {"title": "Art and Craft", "img": "assets/images/arts.webp"},
  {"title": "Video Games ", "img": "assets/images/ps5.jpg"},
  {"title": "Music", "img": "assets/images/music.png"},
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
