import 'dart:convert';

import 'package:cvapp/navbar.dart';
import 'package:cvapp/screens/home_screen.dart';
import 'package:cvapp/screens/register_screen.dart';
import 'package:cvapp/utils/api_endpoints.dart';
import 'package:cvapp/wedgets/costom_divider.dart';
import 'package:cvapp/wedgets/sginin_text_wedget.dart';
import 'package:cvapp/wedgets/welcome_wedget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isvaild = false;

class SginInScreen extends StatefulWidget {
  const SginInScreen({super.key});

  @override
  State<SginInScreen> createState() => _SginInScreenState();
}

class _SginInScreenState extends State<SginInScreen> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emaiilcontroller = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> verifyOtp() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.login);

      Map body = {
        'password': passwordcontroller.text,
        'email': emaiilcontroller.text,
      };

      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        isvaild = true;
        final json = jsonDecode(response.body);
        var token = json['data']['token'];
        print(token);
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', token);
        print("suscess");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff8C5CB3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            WelcomeWidget("Login to CV app"),
            SizedBox(
              height: 20,
            ),
            CustomDivider(),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                SginInText(
                    emaiilcontroller: emaiilcontroller, labelText: "Email"),
                SizedBox(
                  height: 30,
                ),
                SginInText(
                  emaiilcontroller: passwordcontroller,
                  labelText: "Password",
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    await verifyOtp();
                    if (isvaild == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NavBar()));
                    } else {
                      showAboutDialog(
                          context: context,
                          children: [Text("please enter valid data")]);
                    }
                  },
                  child: Container(
                    width: 180,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
               
                Stack(
                  children: [
                    Container(
                      width: 390,
                      height: 350,
                    ),
                    Positioned(
                      left: 170,
                      top: 120,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 300,
                        height: 200,
                        child: Image.asset(
                          "lib\\assets\\imges\\img2.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 50,
                        left: 50,
                        child: Text(
                          "Dont have an account?",
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        )),
                    Positioned(
                        top: 77,
                        left: 130,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
