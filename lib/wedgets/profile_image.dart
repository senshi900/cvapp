import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.selectedimage,
  });

  final File selectedimage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.amber,
        ),
        // Displaying the selected image
        child: Image.file(selectedimage, fit: BoxFit.contain,)
         
        ),
      
    );
  }
}
