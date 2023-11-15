import 'package:flutter/material.dart';

class SginInText extends StatelessWidget {
  const SginInText({
    super.key,
    required this.emaiilcontroller,
    required this.labelText,
  });

  final TextEditingController emaiilcontroller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(offset: Offset(3, 4), blurRadius: 10, color: Colors.black)
      ], borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: TextField(
        controller: emaiilcontroller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(17)),
            hintText: labelText),
      ),
    );
  }
}
