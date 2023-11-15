import 'dart:async';
import 'dart:convert';

import 'package:cvapp/screens/login_screen.dart';
import 'package:cvapp/utils/api_endpoints.dart';
import 'package:cvapp/wedgets/sginup_wedget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isvalid = false;

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.mycontroller});
  final mycontroller;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController emaiilcontroller = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> verifyOtp() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.verification);

      Map body = {
        'otp': otpcontroller.text,
        'email': widget.mycontroller,
        'type': 'registration',
      };

      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var token = json['data']['token'];
        print(token);
        isvalid = true;
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
      backgroundColor: Color(0xff8C5CB3),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            SinUpWedget(
              Controller: otpcontroller,
              labelText: "otp",
            ),
            SizedBox(
              height: 20,
            ),
           
            ElevatedButton(
              onPressed: () async {
                await verifyOtp();
                if (isvalid == true) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SginInScreen()));
                } else {
                  showAboutDialog(
                      context: context, children: [Text("invalid otp")]);
                }
              },
              child: const Text('Submit'),
            ),
            
          ],
        ),
      ),
    );
  }
}
