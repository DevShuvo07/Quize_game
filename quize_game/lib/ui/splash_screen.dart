import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quize_game/const/colors.dart';
import 'package:quize_game/const/text_style.dart';
import 'package:quize_game/ui/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.push(context, CupertinoPageRoute(builder: (_)=>Homepage(title: 'Homepage',)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //App Splash Screen Name and Progress Bar.
              heading_text(text: "Quize App", color: Colors.white, size: 32),
              SizedBox(height: 20,),
              CircularProgressIndicator(color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}