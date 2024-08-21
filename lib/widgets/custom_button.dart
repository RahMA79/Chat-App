import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, this.onTap});
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
