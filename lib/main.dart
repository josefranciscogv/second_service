import 'package:flutter/material.dart';
import 'package:second_service/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Second Service', home: HomePage());
  }
}
