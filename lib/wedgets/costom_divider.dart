import 'package:flutter/material.dart';

Row CustomDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 60,
        height: 2,
        color: Colors.black,
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        "Or log in with Email",
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        width: 60,
        height: 2,
        color: Colors.black,
      ),
    ],
  );
}
