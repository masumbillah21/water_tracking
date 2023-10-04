import 'package:flutter/material.dart';
import 'package:water_tracking/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Tracking',
      home: const HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 50,
          ),
          bodyMedium: TextStyle(
            fontSize: 30,
          ),
          headlineLarge: TextStyle(
            fontSize: 30,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
