import 'dart:io';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/input_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static const String routeName = '/add-product';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final SellerService sellerService = SellerService();

  String selectedtype = 'Electronics';
  List<File> selectedImages = [];

  final addProductKey = GlobalKey<FormState>();
  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? pickedFiles = await picker.pickMultiImage();

    setState(() {
      selectedImages =
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    });
  }

  void addNewProduct(name, price, description, stock, type, images) {
    sellerService.addNewProduct(
        context: context,
        name: name,
        price: price,
        description: description,
        stock: stock,
        type: type,
        images: images);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: appBarGradient),
        ),
        title: const Text(
          'Add a product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: addProductKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  pickImages(); 
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  child: Center(
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: selectedImages.isEmpty
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 45,
                                ),
                                Text(
                                  'Select images of new product',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            )
                          :
                          //in case you pick one image though make sure it fills the screen
                          selectedImages.length == 1
                              ? Image.file(
                                  selectedImages[0],
                                  // fit: BoxFit.cover,
                                )
                              : GridView.builder(
                                  itemCount: selectedImages.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Image.file(
                                      selectedImages[index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InputField(
                  controller: nameController,
                  hintText: 'Enter product name',
                  maxLines: 1),
              const SizedBox(
                height: 15,
              ),
              InputField(
                  controller: priceController,
                  hintText: 'Enter product price',
                  maxLines: 1),
              const SizedBox(
                height: 15,
              ),
              InputField(
                  controller: descriptionController,
                  hintText: 'Enter product description',
                  maxLines: 7),
              const SizedBox(
                height: 15,
              ),
              InputField(
                controller: stockController,
                hintText: 'Enter product stock',
                maxLines: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButton(
                value: selectedtype,
                hint: const Text('select item type'),
                items: const [
DropdownMenuItem(
    value: 'Electronics',
    child: Text('Electronics'),
  ),
  DropdownMenuItem(
    value: 'Fashion',
    child: Text('Fashion'),
  ),
  DropdownMenuItem(
    value: 'Home and Kitchen',
    child: Text('Home and Kitchen'),
  ),
  DropdownMenuItem(
    value: 'Health and Personal Care',
    child: Text('Health and Personal Care'),
  ),
  DropdownMenuItem(
    value: 'Books and Stationery',
    child: Text('Books and Stationery'),
  ),
  DropdownMenuItem(
    value: 'Sports and Outdoors',
    child: Text('Sports and Outdoors'),
  ),
  DropdownMenuItem(
    value: 'Toys and Games',
    child: Text('Toys and Games'),
  ),
  DropdownMenuItem(
    value: 'Beauty and Cosmetics',
    child: Text('Beauty and Cosmetics'),
  ),
  DropdownMenuItem(
    value: 'Automotive',
    child: Text('Automotive'),
  ),
  DropdownMenuItem(
    value: 'Jewelry and Accessories',
    child: Text('Jewelry and Accessories'),
  ),
  DropdownMenuItem(
    value: 'Groceries and Food',
    child: Text('Groceries and Food'),
  ),
  DropdownMenuItem(
    value: 'Baby Products',
    child: Text('Baby Products'),
  ),
  DropdownMenuItem(
    value: 'Pet Supplies',
    child: Text('Pet Supplies'),
  ),
  DropdownMenuItem(
    value: 'Tools and Hardware',
    child: Text('Tools and Hardware'),
  ),
  DropdownMenuItem(
    value: 'Office Supplies',
    child: Text('Office Supplies'),
  ),
  DropdownMenuItem(
    value: 'Musical Instruments',
    child: Text('Musical Instruments'),
  ),
  DropdownMenuItem(
    value: 'Furniture',
    child: Text('Furniture'),
  ),
  DropdownMenuItem(
    value: 'Art and Craft',
    child: Text('Art and Craft'),
  ),
  DropdownMenuItem(
    value: 'Industrial and Scientific',
    child: Text('Industrial and Scientific'),
  ),
  DropdownMenuItem(
    value: 'Video Games and Consoles',
    child: Text('Video Games and Consoles'),
  ),
  DropdownMenuItem(
    value: 'Music',
    child: Text('Music'),
  ),                ],
                onChanged: (value) {
                  setState(() {
                    selectedtype = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  //images not a form field so check for that as well
                  if (addProductKey.currentState!.validate() && selectedImages.isNotEmpty) {
                    addNewProduct(
                        nameController.text.trim(),
                        double.parse(priceController.text.trim()),
                        descriptionController.text.trim(),
                        int.parse(stockController.text.trim()),
                        selectedtype,
                        selectedImages,);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: secondaryColor,
                  elevation: 1,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
