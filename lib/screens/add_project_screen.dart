import 'dart:convert';
import 'dart:io';

import 'package:cvapp/global.dart';
import 'package:cvapp/models/edcuation_model.dart';
import 'package:cvapp/models/getprjectmodel%20.dart';
import 'package:cvapp/models/skills_model.dart';
import 'package:cvapp/models/social_model.dart';
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
class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key, });
  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}
class Item {
  String projectname;
  String description;
  String state;

  Item(
      {required this.projectname,
      required this.description,
      required this.state});
}
class _ProjectScreenState extends State<ProjectScreen> {
  List<Item> items = [];
  List<getprjectmodel> projectlist = [];
  bool isvalid = false;
  TextEditingController projectnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  void _addItem(String projectnameController, String descriptionController,
      String stateController) {
    if (projectnameController.isNotEmpty && descriptionController.isNotEmpty) {
      setState(() {
        items.add(Item(
            projectname: projectnameController,
            description: descriptionController,
            state: stateController));
      });
    }
  }


  Future pushproject({required String token}) async {
    try {
      Map body = {
        "name": projectnameController.text,
        "description": descriptionController.text,
        "state": stateController.text,
      };
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.project);
      var response = await http.post(url,
          headers: {"authorization": token}, body: json.encode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        SkillsModel.fromJson(json.decode(response.body));
        isvalid = true;
      } else {
      }
    } catch (e) {
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

  Future<void> feachproject({required String token}) async {
    var url = Uri.parse("https://bacend-fshi.onrender.com/user/projects");
    try {
      var response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'] as List;
        setState(() {
          projectlist =
              jsonData.map((e) => getprjectmodel.fromJson(e)).toList();
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
   Future<void> RemoveProject(int id) async {
    var url = Uri.parse("https://bacend-fshi.onrender.com/user/delete/project");
    try {
      var response = await http.delete(url,
          headers: {"Authorization": "Bearer $token"},
          body: json.encode({"id_project": id}));
      print(id);
      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Education  deleted successfully')));
        feachproject(token: '$token');
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
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200, height: 200, child: Image.file(selectedimage))
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: SinUpWedget(
                  Controller: projectnameController,
                  labelText: "  Enter your project name"),
            ),
          
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: SinUpWedget(
                  Controller: descriptionController,
                  labelText: "  Enter your description"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: SinUpWedget(
                  Controller: stateController, labelText: "  Enter your state"),
            ),
            ElevatedButton(
                onPressed: () async {
                  await pushproject(token: token.toString());
                  await feachproject(token: token.toString());
                  print(token);
                  setState(() {});
                },
                child: Text("Add")),
            SizedBox(
              width: 300,
              height: 200,
              child: ListView.builder(
                itemCount: projectlist.length,
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
                          'your project name : ${projectlist[index].name.toString()}',
                          style: TextStyle(
                              color:  Colors.white),
                        ),SizedBox(height: 5,),
                        Text(
                          'State : ${projectlist[index].state}',
                          style: TextStyle(
                              color:  Colors.white),
                        ),SizedBox(height: 5,),
                        Text(
                          'Description : ${projectlist[index].description}',
                          style: TextStyle(
                              color:  Colors.white),
                        ),
      
                        TextButton(
                          onPressed: () {
                            socialcounter += 1;
                            RemoveProject(projectlist[index].id!);
                            setState(() {
                              
                            });
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
