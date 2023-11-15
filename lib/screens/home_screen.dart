import 'dart:convert';
import 'dart:io';

import 'package:cvapp/global.dart';
import 'package:cvapp/models/skills_model.dart';
import 'package:cvapp/screens/add_project_screen.dart';
import 'package:cvapp/screens/education_screen.dart';
import 'package:cvapp/screens/register_screen.dart';
import 'package:cvapp/screens/skills_screen.dart';
import 'package:cvapp/screens/social_screen.dart';
import 'package:cvapp/screens/welocme_screen.dart';
import 'package:cvapp/utils/api_endpoints.dart';
import 'package:cvapp/wedgets/add_data.dart';
import 'package:cvapp/wedgets/profile_image.dart';
import 'package:cvapp/wedgets/sginup_wedget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
String? token;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future imageupload({required String token}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("https://bacend-fshi.onrender.com/user/upload"));
      request.headers.addAll({"authorization": token});

      if (selectedimage != null) {
        request.files.add(
            await http.MultipartFile.fromPath('image', selectedimage.path));
      }

      var response = await request.send();
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.request);
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return SkillsModel.fromJson(json.decode(responseData));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Failed to upload image. Status code: ${response.statusCode}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8C5CB3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            SizedBox(height: 60),
              Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back))
                        ,Icon(Icons.logout)
                    
                    
                      ],),
                    ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

           Container(width: 100,height: 100,child: Image.file(selectedimage),),
                    // Image.network(userData['image']),
                 
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProjectScreen()));
                    },
                    child: Adddata(
                        img: "lib\\assets\\imges\\img4.png",
                        dataname: "projects",
                        datanumbers: "0")),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SkillsScreen()));
                  },
                  child: Adddata(
                      img: "lib\\assets\\imges\\img5.png",
                      dataname: "Skills",
                      datanumbers: "0"),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EducationScreen(
                                  imgpath1: selectedimage,
                                )));
                  },
                  child: Adddata(
                      img: "lib\\assets\\imges\\img6.png",
                      dataname: "education ",
                      datanumbers: "0"),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    print(selectedimage.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SocialScreen(
                                  imgpath: selectedimage,
                                )));
                  },
                  child: Adddata(
                      img: "lib\\assets\\imges\\img9.png",
                      dataname: "social ",
                      datanumbers: "${socialcounter}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future pickImageFromGallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedimage != null) {
      setState(() {
        selectedimage = File(returnedimage.path);

        imageupload(token: token.toString());
        print(selectedimage);
      });
    }
  }
}
