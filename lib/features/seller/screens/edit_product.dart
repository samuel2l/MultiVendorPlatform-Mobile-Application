import 'dart:io';

import 'package:multivendorplatformmobile/constants.dart';
import 'package:multivendorplatformmobile/features/models/product.dart';
import 'package:multivendorplatformmobile/features/seller/services/seller_service.dart';
import 'package:multivendorplatformmobile/features/common/widgets/input_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendorplatformmobile/features/seller/widgets/select_colors.dart';
import 'package:multivendorplatformmobile/features/seller/widgets/select_sizes.dart';
import 'package:multivendorplatformmobile/theme.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key, required this.product});
  static const String routeName = '/edit-product';
  final Product product;
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final SellerService sellerService = SellerService();
  List<String> selectedSizes = [];
  String selectedtype = 'Electronics';
  List<File> selectedImages = [];
  List<String> selectedColors = [];

  @override
  void initState() {
    super.initState();
  }

  final editProductKey = GlobalKey<FormState>();
  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? pickedFiles = await picker.pickMultiImage();

    setState(() {
      selectedImages =
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    });
  }

  void editProduct(name, price, description, stock, type) {
    if (selectedImages.isEmpty) {
      sellerService.editProduct(
          context: context,
          name: name,
          price: price.toDouble(),
          description: description,
          stock: stock,
          type: type,
          id: widget.product.id,
          selectedSizes:
              selectedSizes.isEmpty ? widget.product.sizes : selectedSizes,
          selectedColors:
              selectedColors.isEmpty ? widget.product.colors : selectedColors);
    } else {
      sellerService.editProduct(
          context: context,
          name: name,
          price: price,
          description: description,
          stock: stock,
          type: type,
          images: selectedImages,
          id: widget.product.id,
          selectedSizes:
              selectedSizes.isEmpty ? widget.product.sizes : selectedSizes,
          selectedColors:
              selectedColors.isEmpty ? widget.product.colors : selectedColors);
    }
    setState(() {});
  }

  void showSizesDialog() async {
    List<String>? sizesSelected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SelectSizes(items: sizes);
      },
    );

    if (sizesSelected != null) {
      setState(() {
        selectedSizes = sizesSelected;
      });
    }
  }

  void showColorsDialog() async {
    List<String>? colorsSelected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SelectColors(items: colors);
      },
    );

    if (colorsSelected != null) {
      setState(() {
        selectedColors = colorsSelected;
      });
    }
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
    print(widget.product.sizes);
    print(widget.product.colors);
    print("doinwfewf");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Edit ${widget.product.name}',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: editProductKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  pickImages();
                },
                child: DottedBorder(
                  color: Theme.of(context).brightness == Brightness.light
                      ? black
                      : lightAsh,
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
                  hintText: widget.product.name,
                  maxLines: 1),
              const SizedBox(
                height: 15,
              ),
              InputField(
                  controller: priceController,
                  hintText: widget.product.price.toString(),
                  maxLines: 1),
              const SizedBox(
                height: 15,
              ),
              InputField(
                  controller: descriptionController,
                  hintText: widget.product.desc,
                  maxLines: 7),
              const SizedBox(
                height: 15,
              ),
              InputField(
                controller: stockController,
                hintText: widget.product.stock.toString(),
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
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedtype = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Only applies if your product has sizes"),
              TextButton(
                  onPressed: () {
                    showSizesDialog();
                  },
                  child: const Text("Select Sizes")),
              const SizedBox(
                height: 10,
              ),
              widget.product.sizes.isNotEmpty
                  ? const Text("Current sizes")
                  : const SizedBox.shrink(),
              widget.product.sizes.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: widget.product.sizes.map(
                        (size) {
                          print("SIZEEEE $size");
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // padding: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: ash),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(sizeMapping[size]!),
                            ),
                          );
                        },
                      ).toList()))
                  : const SizedBox.shrink(),
              selectedSizes.isNotEmpty
                  ? const Text("New Selected Sizes")
                  : const SizedBox.shrink(),
              selectedSizes.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: selectedSizes.map(
                        (size) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // padding: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: ash),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(sizeMapping[size]!),
                            ),
                          );
                        },
                      ).toList()))
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              const Text("Only applies if your product has  colors"),
              TextButton(
                  onPressed: () {
                    showColorsDialog();
                  },
                  child: const Text("Select Colors")),
              const SizedBox(
                height: 10,
              ),
                            widget.product.sizes.isNotEmpty
                  ? const Text("Current colors")
                  : const SizedBox.shrink(),
              widget.product.colors.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: widget.product.colors.map(
                        (color) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 37,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorDictionary
                                            .containsKey(color.toLowerCase())
                                        ? colorDictionary[color.toLowerCase()]
                                        : white,
                                  ),
                                  child: const Center(child: Text("")),
                                ),
                                Text(color)
                              ],
                            ),
                          );
                        },
                      ).toList()))
                  : const SizedBox.shrink(),
              selectedColors.isNotEmpty
                  ? const Text("New Selected Colors")
                  : const SizedBox.shrink(),

              selectedColors.isNotEmpty
                  ? const Text("Selected Colors")
                  : const SizedBox.shrink(),
              selectedColors.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: selectedColors.map(
                        (color) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 37,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorDictionary
                                            .containsKey(color.toLowerCase())
                                        ? colorDictionary[color.toLowerCase()]
                                        : white,
                                  ),
                                  child: const Center(child: Text("")),
                                ),
                                Text(color)
                              ],
                            ),
                          );
                        },
                      ).toList()))
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  editProduct(
                    nameController.text.trim().isEmpty
                        ? widget.product.name
                        : nameController.text.trim(),
                    priceController.text.isEmpty
                        ? widget.product.price
                        : double.parse(priceController.text.trim().toString()),
                    descriptionController.text.trim().isEmpty
                        ? widget.product.desc
                        : descriptionController.text.trim(),
                    stockController.text.trim().isEmpty
                        ? widget.product.stock
                        : int.parse(stockController.text.trim()),
                    selectedtype,
                  );
                },
                child: Text('Edit ${widget.product.name}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
