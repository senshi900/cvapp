import 'dart:convert';
import 'dart:io';

import 'package:cvapp/get_models/get_skills.dart';
import 'package:cvapp/global.dart';
import 'package:cvapp/models/skills_model.dart';
import 'package:cvapp/screens/welocme_screen.dart';
import 'package:cvapp/utils/api_endpoints.dart';
import 'package:cvapp/wedgets/logo_fun_back_logout.dart';
import 'package:cvapp/wedgets/sginup_wedget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
String? token;

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  List<SkillsModel>? skillLsit;

  bool isvalid = false;
  TextEditingController skillcontroller = TextEditingController();

  Future pushproject({required String token}) async {
    try {
      Map body = {
        "skill": skillcontroller.text,
      };
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.addskills);
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

  Future<void> fetchSkills({required String token}) async {
    var url = Uri.parse("https://bacend-fshi.onrender.com/user/skills");

    try {
      var response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'] as List;
        setState(() {
          skillLsit = data.map((e) => SkillsModel.fromJson(e)).toList();
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
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token");
    });
  }

  Future<void> RemoveSkill(int id) async {
    var url = Uri.parse("https://bacend-fshi.onrender.com/user/delete/skills");
    try {
      var response = await http.delete(url,
          headers: {"Authorization": "Bearer $token"},
          body: json.encode({"id_skill": id}));
      print(id);
      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Education  deleted successfully')));
        fetchSkills(token: '$token'); // Refresh the list after deletion
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
      body: Column(
        children: [SizedBox(height: 50),
           BackAndremove(context),
          SizedBox(height: 50),
            
           Container(width: 200,height: 200,child: Image.file(selectedimage),),

          Divider(
            thickness: 1,
          ),
          Container(
            width: 300,
            height: 60,
            child: SinUpWedget(
                Controller: skillcontroller, labelText: "  Enter your skill"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                await pushproject(token: token.toString());
                await fetchSkills(token: token.toString());
                print(token);
                setState(() {});
              },
              child: Text("Add")),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 250,
                child: skillLsit == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: skillLsit!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () async {
                              await RemoveSkill(skillLsit![index].id);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black),
                              child: Text(
                                skillLsit![index].skill,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}
