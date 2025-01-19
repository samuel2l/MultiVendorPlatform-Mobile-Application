import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multivendorplatformmobile/features/profile/services/profile_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  static const String routeName = '/edit-profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? selectedImage;
  ProfileService profileService = ProfileService();
  @override
  void initState() {
    profileService.updateProfile(
        name: 'untouched name',
        gender: 'untouched gender',
        street: 'untouched street',
        postalCode: 'untouched postalCode',
        city: 'untouched city',
        country: 'untouched country',
        context: context);
    super.initState();
  }

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final genderController = TextEditingController();

  String countryFlag = '';
  String countryCode = '';
  bool isSelected = true;
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        setState(() {
          countryFlag = country.flagEmoji;
          countryCode = country.phoneCode;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 70,
                      // ClipOval ensures the image fits the CircleAvatar
                      child: selectedImage != null
                          ? ClipOval(
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              ),
                            )
                          : Image.asset(
                              'assets/images/pp.jpeg',
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 260,
                    child: GestureDetector(
                      onTap: pickImages,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0XFFFEC400)),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Evans Acheampong',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0XFF5A5A5A),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'sjsdwd@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Update mobile name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            countryFlag,
                            style: const TextStyle(fontSize: 40),
                          ),
                          GestureDetector(
                            onTap: selectCountry,
                            child: const Icon(Icons.arrow_drop_down),
                          ),
                          Text(
                            countryCode == '' ? '' : '+$countryCode',
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            padding: const EdgeInsets.all(18.0),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 24),
                )),
          )
        ],
      ),
    );
  }
}
