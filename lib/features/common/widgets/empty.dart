import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty(
      {super.key,
      required this.img,
      required this.title,
      required this.subtitle,
      required this.btnText});
  final String img;
  final String title;
  final String subtitle;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(img),
            Text(
              title,
              style: const TextStyle(fontSize: 26),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
