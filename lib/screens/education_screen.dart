import 'dart:convert';
import 'dart:io';

import 'package:cvapp/global.dart';
import 'package:cvapp/models/edcuation_model.dart';
import 'package:cvapp/models/skills_model.dart';
import 'package:cvapp/screens/register_screen.dart';
import 'package:cvapp/utils/api_endpoints.dart';
import 'package:cvapp/wedgets/logo_fun_back_logout.dart';
import 'package:cvapp/wedgets/profile_image.dart';
import 'package:cvapp/wedgets/sginup_wedget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
String? token;

class EducationScreen extends StatefulWidget {
  const EducationScreen({super.key, required this.imgpath1});
  final File imgpath1;

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  File? selectedimage;
  List<educationmodel> educationlist = [];
  bool isvalid = false;
  TextEditingController graduation_dateController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  Future pushproject({required String token}) async {
    try {
      Map body = {
        "graduation_date": graduation_dateController.text,
        "university": universityController.text,
        "college": collegeController.text,
        "specialization": specializationController.text,
        "level": levelController.text,
      };
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.addeducation);
      var response = await http.post(url,
          headers: {"authorization": token}, body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        SkillsModel.fromJson(json.decode(response.body));
        isvalid = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Success!')));
      } else {}
    } catch (e) {
      // Handle the exception
    }
  }

  Future<void> fetcheducation({required String token}) async {
    var url = Uri.parse("https://bacend-fshi.onrender.com/user/education");

    try {
      var response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
      print(response.body);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'] as List;
        setState(() {
          educationlist =
              jsonData.map((e) => educationmodel.fromJson(e)).toList();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadToken(); // Call an async method to load the token
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token");
    });
  }

  Future<void> RemoveEducation(int id) async {
    var url =
        Uri.parse("https://bacend-fshi.onrender.com/user/delete/education");
    try {
      var response = await http.delete(url,
          headers: {"Authorization": "Bearer $token"},
          body: json.encode({"id_education": id}));
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Education  deleted successfully')));
        fetcheducation(token: '$token'); // Refresh the list after deletion
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete social media.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff8C5CB3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
             BackAndremove(context),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 100, height: 100, child: Image.file(widget.imgpath1))
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: SinUpWedget(
                Controller: graduation_dateController,
                labelText: " Enter your graduation date as 02/11/2001",
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "please enter your graduation date";
                  } else if (p0.contains("/")) {
                    return "please enter your graduation date as 02/11/2001";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: SinUpWedget(
                  Controller: universityController,
                  labelText: "  Enter your university"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: SinUpWedget(
                  Controller: collegeController, labelText: " Enter your college"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: SinUpWedget(
                  Controller: specializationController,
                  labelText: " Enter your specialization"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: SinUpWedget(
                  Controller: levelController, labelText: " Enter your level"),
            ),
            ElevatedButton(
                onPressed: () async {
                  await pushproject(token: token.toString());
                  await fetcheducation(token: token.toString());
                  print(token);
                  setState(() {});
                },
                child: Text("Add")),
            SizedBox(
              width: 300,
              height: 170,
              child: ListView.builder(
                itemCount: educationlist.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "you graduate at :${educationlist[index].graduationDate}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "you graduate from: ${educationlist[index].university}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "your specialization is : ${educationlist[index].specialization}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "your level is : ${educationlist[index].level}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(),
                        TextButton(
                          onPressed: () {
                            socialcounter += 1;
                            RemoveEducation(educationlist[index].id!);
                          },
                          child:
                              Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child:Column(children: [Text("your college is ${educationlist![index].college.toString()}",),
// Text("you graduate at ${educationlist![index].graduationDate.toString()}"),
// Text("you graduate from ${educationlist![index].university.toString()}"),
// Text("your specialization is  ${educationlist![index].specialization.toString()}"),
// Text("your level is  ${educationlist![index].level.toString()}")
