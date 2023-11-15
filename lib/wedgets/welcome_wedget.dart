import 'package:flutter/material.dart';

Row WelcomeWidget(String topText) {
  // Changed function name to "WelcomeWidget" and added "String topText" as a parameter
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Text(
            topText, // Replaced "toptext" with the parameter "topText"
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                  height: 60,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black)),
              Positioned(
                left: 90,
                top: 15,
                child: Text(
                  "Login in With Google",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                left: 50,
                top: 15,
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("lib\\assets\\imges\\img3.png"),
                ),
              )
            ],
          )
        ],
      ),
    ],
  );
}
