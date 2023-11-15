import 'dart:convert';
import 'package:cvapp/screens/vervcation_screen.dart';
import 'package:cvapp/wedgets/costom_divider.dart';
import 'package:cvapp/wedgets/imge_sinup.dart';
import 'package:cvapp/wedgets/sginup_wedget.dart';
import 'package:cvapp/wedgets/welcome_wedget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cvapp/utils/api_endpoints.dart';
import 'package:cvapp/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // GlobalKey for FormState
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String errorMessage = "";

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Input'),
            content: Text('Please correct the errors in the form.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.registerEmail);
      Map body = {
        "name": nameController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
        "email": emailController.text
      };
      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationScreen(
                      mycontroller: emailController.text,
                    ))); // Ensure this is the correct navigation
      } else {
        setState(() {
          errorMessage = "Registration failed. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff8C5CB3),
      body: SingleChildScrollView(
        child: Column(
          
          children: <Widget>[
            SizedBox(height: 40),
            WelcomeWidget("Login to CV app"),
            SizedBox(height: 20),
            CustomDivider(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SinUpWedget(
                      Controller: nameController,
                      labelText: "   Enter your name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your name";
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SinUpWedget(
                      Controller: phoneController,
                      labelText: "  Enter your phone",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "please enter your phone";
                        } else if (p0.length > 11 || p0.length < 10) {
                          return "it should be 10 numbers";
                        } else if (!p0.startsWith("05")) {
                          return "it should start with 05";
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SinUpWedget(
                      Controller: emailController,
                      labelText: "  Enter your email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your email";
                        } else if (!value.contains("@")) {
                          return "please enter valid email";
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    SinUpWedget(
                      Controller: passwordController,
                      labelText: "  Enter your password",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "please enter your password";
                        } else if (p0.length < 1) {
                          return "please enter your password";
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading) CircularProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(errorMessage, style: TextStyle(color: Colors.red)),
              ),
            RegisterButton(_register),
          
             Stack(
              children: [
                Container(
                  width: 390,
                  height: 300,
                ),
                Positioned(bottom: 60, child: Costomimage()),
              
                Positioned(
                    top: 50,
                    left: 170,
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Positioned(
                    top: 80,
                    left: 280,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SginInScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final Future<void> Function() registerFunction;

  const RegisterButton(this.registerFunction);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await registerFunction();
      },
      child: Text(
        'Create Account',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(200, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
