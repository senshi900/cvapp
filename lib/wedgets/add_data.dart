
import 'package:flutter/material.dart';

class Adddata extends StatelessWidget {
  const Adddata({
    super.key, required this.img, required this.dataname, required this.datanumbers,
  });
  final String img;
  final String dataname;
  final String datanumbers;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(width: 200,height: 100,decoration: BoxDecoration(boxShadow: [BoxShadow(offset: Offset(3, 4), blurRadius: 12, color: Colors.black)],borderRadius: BorderRadius.circular(16),color: Colors.white),),
      Positioned(top: 60,left: 90,child: Text(dataname,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
      Positioned(top: 20,left: 90,child: Text("you have : ${datanumbers}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
      Positioned(
        top: 20,left: 20,
        child: SizedBox(
          width: 60,height: 60,
          child: Image.asset(img)),
      )
    
      
    ],);
  }
}
