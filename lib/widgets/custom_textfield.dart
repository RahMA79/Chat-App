import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CutomTextFormField extends StatelessWidget {
  CutomTextFormField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.validator,
      this.obscureText = false,
      this.suffixIcon,
      this.controller,
      this.prefixIcon,
      this.onChanged});
  final String hintText;
  final String labelText;
  bool obscureText;
  Function(String)? onChanged;
  final String? Function(String?) validator;
  Icon? prefixIcon;
  GestureDetector? suffixIcon;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffix: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: primaryColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor, width: 2)),
          hintText: hintText,
          hintStyle:
              TextStyle(color: Colors.grey[600], fontFamily: 'Montserrat'),
          labelText: labelText,
          labelStyle:
              TextStyle(color: Colors.grey[800], fontFamily: 'Montserrat'),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 16)),
    );
  }
}
