import 'package:flutter/material.dart';
import 'package:hirola_app/presentation/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hirola app',
      debugShowCheckedModeBanner: false, 
      home: HomeScreen()
    );
  }
}

