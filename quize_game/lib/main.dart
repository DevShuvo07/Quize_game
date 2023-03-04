import 'package:flutter/material.dart';
import 'package:quize_game/ui/homepage.dart';
import 'package:quize_game/ui/splash_screen.dart';

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
      title: 'Quize App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "quick",
      ),
      home: SplashScreen()
    );
  }
}