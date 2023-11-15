import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cvapp/global.dart';
import 'package:cvapp/models/social_model.dart';

class ApiEndpoints {
  static final String baseUrl = "https://bacend-fshi.onrender.com/";
  static AuthEndPoints authEndPoints = AuthEndPoints();
}

class AuthEndPoints {
  final registerEmail = "auth/registration";
  final String verification = "auth/verification";
  final String login = "auth/login";
  final String project = "user/add/project";
  final String addskills = "user/add/skills";
  final String addeducation = "user/add/education";
  final String addsocial = "user/skills";

  final String getskills = "user/add/social_media";
}
