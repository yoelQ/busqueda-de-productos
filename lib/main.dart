import 'package:flutter/material.dart';
import 'package:tarea_api/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TotalStore',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SearchPage(), 
      
    );
  }
}