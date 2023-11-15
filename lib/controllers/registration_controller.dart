import 'dart:convert';

import 'package:cvapp/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrationController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
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
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print("suscess");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
