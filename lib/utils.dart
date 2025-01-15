import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context,'Bad request, try again');
      break;
    case 500:
      showSnackBar(context,'Server error please try again later');
      break;
    default:
      showSnackBar(context, "something went wrong");
  }
}

void showSnackBar(BuildContext context, String text) {
 try{
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );

 }catch(e){
  print(e);
 }
}

