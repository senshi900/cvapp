
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cvapp/screens/home_screen.dart';
import 'package:cvapp/screens/print_users_screen.dart';
import 'package:cvapp/screens/profile_screen.dart';
import 'package:cvapp/screens/register_screen.dart';
import 'package:cvapp/screens/welocme_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final items= [
       
        Icon(Icons.person, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.list, size: 30),
       
     
      ];
      int index =1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xff8C5CB3),

      bottomNavigationBar: CurvedNavigationBar(color: Colors.deepPurple.shade200,
        backgroundColor: Color(0xff8C5CB3),
        height: 60,
        items:items,
      index: index,
      onTap: (selectedindex) {
        print(index);
        setState(() {
          index=selectedindex;
        });
      
        
      },
      ),
      body: Container(
        color: Colors.blue,
       
        alignment: Alignment.center,
        child: selectedpage(index: index),
        
      ),
    );
  }
 Widget selectedpage({required int index}) {
  Widget widget = HomeScreen(); 

  switch(index) {
    case 0:
      widget = ProfileScreen();
      break;
    case 1:
      widget = HomeScreen();
      break;
    case 2:
      widget = GetUsersScreen();
      break;
    default:
      widget = HomeScreen(); 
  }

  return widget;
}

 
}

 