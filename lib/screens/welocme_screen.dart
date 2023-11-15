import 'package:cvapp/screens/login_screen.dart';
import 'package:cvapp/screens/register_screen.dart';
import 'package:cvapp/wedgets/sgin_continer.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8C5CB3),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 69,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Welcome to ",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Text(
              "Cv App ",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 9),
            child: Text(
              "A place where you can create your own cv",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Container(
                  height: 150,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(1))),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                  width: 150,
                  height: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Container(
                      height: 150,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(1))),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: Container(
                      width: 150,
                      height: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              SginContiner(),
            ],
          ),
          SizedBox(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(fontSize: 17),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SginInScreen()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
