import 'package:cvapp/navbar.dart';
import 'package:cvapp/screens/add_project_screen.dart';
import 'package:cvapp/screens/home_screen.dart';
import 'package:cvapp/screens/register_screen.dart';
import 'package:cvapp/screens/skills_screen.dart';
import 'package:cvapp/screens/test.dart';
import 'package:cvapp/screens/welocme_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WelcomeScreen());
  }
}
