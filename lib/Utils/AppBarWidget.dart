
import 'dart:io';

import 'package:flutter/material.dart';

class AppBarWidget{

  Widget getAppbar(String title,BuildContext context){
    return AppBar(leading: IconButton(
      icon: Icon(Platform.isIOS? Icons.arrow_forward_ios_outlined:Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),automaticallyImplyLeading: true,
      title: Text("$title", style: TextStyle(color: Colors.black),),
      toolbarHeight: 40,
      backgroundColor: Colors.white,);
  }
}