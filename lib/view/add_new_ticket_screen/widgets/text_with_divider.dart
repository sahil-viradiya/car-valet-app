import 'package:flutter/material.dart';

Row textWithDivider({required String text, required TextStyle style}) {
  return Row(
    children: [
      Expanded(
        child: Divider(
            // thickness: 2,
            color: Colors.grey.shade300),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: style,
        ),
      ),
      Expanded(
        child: Divider(
          // thickness: 2,
          color: Colors.grey.shade300,
        ),
      ),
    ],
  );
}
