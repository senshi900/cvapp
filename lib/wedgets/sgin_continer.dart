import 'package:cvapp/screens/register_screen.dart';
import 'package:flutter/material.dart';

class SginContiner extends StatelessWidget {
  const SginContiner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: Container(
        width: 270,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Colors.black),
        child: Center(
          child: Text(
            "Sign up",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
