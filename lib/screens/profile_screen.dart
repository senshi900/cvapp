import 'dart:convert';
import 'package:cvapp/global.dart';
import 'package:cvapp/screens/add_project_screen.dart';
import 'package:cvapp/screens/welocme_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
String? token;
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<Map<String, dynamic>> fetchUserData() async {
    var url = Uri.parse("https://bacend-fshi.onrender.com/user/about");
      var response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load user data');
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
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(child: Text("Profile Screen")),
            
          FutureBuilder<Map<String, dynamic>>(
            future: fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                var userData = snapshot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        
                          
                        
                        InkWell(
                          onTap: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()), (route) => false);
                          },
                          child: Icon(Icons.logout))
                    
                      ],),
                    ),
                    Container(width: 100,height: 100,child: Image.file(selectedimage),),
                    SizedBox(height: 20,),
                    Text("Welcome ${userData['name']}"),
                      TextButton(
                  onPressed: () {
                    pickImageFromGallery();
                    setState(() {});
                  },
                  child: Text("chane image"),),
                    SizedBox(height: 50,),
                     Container(width: 300,height: 45,decoration:BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("username: ${userData['name']}"),
                    ),),
                    SizedBox(height: 20,),


                    Container(width: 300,height: 45,decoration:BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("email :${userData['email']}"),
                    ),),
                    SizedBox(height: 20,),
                    Container(width: 300,height: 45,decoration:BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(" number: ${userData['phone']}"),
                    ),),
                                        SizedBox(height: 20,),

                    Container(width: 300,height: 45,decoration:BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("location: paris"),
                    ),),
                                        SizedBox(height: 20,),

                      Container(width: 100,height: 40,decoration: 
                      BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.black)
                      ,child: Padding(
                        padding: const EdgeInsets.only(top: 12,left: 23),
                        child: Text("Update",style: TextStyle(color: Colors.white),),
                      ),)


                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
