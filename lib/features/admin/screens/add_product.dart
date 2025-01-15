import 'dart:io';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/admin/services/admin_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/input_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static const String routeName = '/admin/add-product';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final AdminService adminService = AdminService();

  String selectedCategory = 'Mobiles';
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

  void addNewProduct(name, price, description, stock, category, images) {
    adminService.addNewProduct(
        context: context,
        name: name,
        price: price,
        description: description,
        stock: stock,
        category: category,
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
                value: selectedCategory,
                hint: const Text('select item category'),
                items: const [
                  DropdownMenuItem(
                    value: 'Mobiles',
                    child: Text('Mobiles'),
                  ),
                  DropdownMenuItem(
                    value: 'Essentials',
                    child: Text('Essentials'),
                  ),
                  DropdownMenuItem(
                    value: 'Appliances',
                    child: Text('Appliances'),
                  ),
                  DropdownMenuItem(
                    value: 'Books',
                    child: Text('Books'),
                  ),
                  DropdownMenuItem(
                    value: 'Fashion',
                    child: Text('Fashion'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
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
                        selectedCategory,
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
