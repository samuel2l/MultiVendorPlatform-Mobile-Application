import 'package:flutter/material.dart';
import 'package:multivendorplatformmobile/theme.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap, required this.imgUrl});
  final IconData? icon;
  final String? imgUrl;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: icon ==null? Image.asset(imgUrl!): Icon(
            icon,
            color: lightAsh,
          ),
          onTap: onTap,
          title: Text(
            title,
            style: TextStyle(color: lightAsh),
          ),
          trailing:const Icon(
            Icons.arrow_forward_ios,
            color: Colors.teal,
          ),
        ),
        const Divider(color: ash)
      ],
    );
  }
}
