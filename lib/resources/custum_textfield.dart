import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.maxLines = 1,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.isPassword = false,
    this.obscureText = true,
    this.toggleVisibility,
    this.hintText = "Enter"
  });

  final int? maxLines;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final bool isPassword;
  final String? hintText;
  final int? maxLength;
  final bool obscureText;
  final VoidCallback? toggleVisibility;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // height: 50,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: isPassword ? obscureText : false,
        maxLength: maxLength,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
            counterText: "",
            //fillColor: ColorCode.ktextfieldClr,
            fillColor: const Color(0xFFF7F7F7),
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
