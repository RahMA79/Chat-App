import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          topLeft: Radius.circular(8)), // Adjust the border radius as needed
    ),
    backgroundColor: primaryColor,
    content: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.w700)),
  ));
}
