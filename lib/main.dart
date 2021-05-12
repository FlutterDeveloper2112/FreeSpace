import 'package:flutter/material.dart';
import 'package:freespace/UI/UserUi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Machine Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserUi(),
    );
  }
}

