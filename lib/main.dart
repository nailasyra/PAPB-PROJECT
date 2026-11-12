
import 'package:flutter/material.dart';
import 'home/home.dart';

void main() {
  runApp(const TomoroApp());
}

class TomoroApp extends StatelessWidget {
  const TomoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomoro Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}
