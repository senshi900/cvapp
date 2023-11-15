import 'package:cvapp/screens/welocme_screen.dart';
import 'package:flutter/material.dart';

Padding BackAndremove(BuildContext context) {
    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back))
                      ,InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()), (route) => false);
                        },
                        child: Icon(Icons.logout))
                  
                  
                    ],),
                  );
  }