import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
String? token;

class GetUsersScreen extends StatefulWidget {
  const GetUsersScreen({super.key});

  @override
  State<GetUsersScreen> createState() => _GetUsersScreenState();
}

class _GetUsersScreenState extends State<GetUsersScreen> {
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

 Future<List<dynamic>> fetchUsers() async {
  var url = Uri.parse("https://bacend-fshi.onrender.com/user/get_users");
  var response = await http.get(url, headers: {"Authorization": "Bearer $token"});
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return json['data'] as List;
  } else {
    throw Exception('Failed to load users');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff8C5CB3), 
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var user = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black, 
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user['image'] != null
                          ? Image.network(user['image'], width: 100, height: 100)
                          : Container(),
                      Text(user['name'], style: TextStyle(color: Colors.white, fontSize: 20)),
                      Text(user['email'], style: TextStyle(color: Colors.white)),
                     
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}