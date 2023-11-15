import 'dart:io';

import 'package:cvapp/models/getprjectmodel%20.dart';
import 'package:cvapp/models/social_model.dart';
import 'package:cvapp/screens/add_project_screen.dart';
import 'package:image_picker/image_picker.dart';

List<Item> projectlist = [];
  String filePath = '/data/user/0/com.example.cvapp/cache/fa822274-af52-4ee4-b731-13f7050f0b8f/1000000033.jpg';
  File selectedimage = File(filePath);
Future pickImageFromGallery() async {
  final returnedimage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

  if (returnedimage != null) {
    selectedimage = File(returnedimage.path);
  }
}

int socialcounter = 0;
List<SocialMediaModel> socialMediaList = [];
String twitter = "lib\\assets\\imges\\img7.png";
