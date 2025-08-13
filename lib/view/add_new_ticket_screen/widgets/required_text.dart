import 'package:flutter/material.dart';
import 'package:wallet_parking/resources/color_code.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Text("$text    ",
            style: const TextStyle(
                fontSize: 14,
                color: ColorCode.klightBlcktext,
                fontWeight: FontWeight.w400)),
        const Positioned(
          top: -2,
          right: 4,
          child: Text(
            "*",
            style: TextStyle(
                fontSize: 14, color: Colors.red, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
