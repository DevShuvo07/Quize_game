import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quize_game/const/colors.dart';
import 'package:quize_game/const/images.dart';
import 'package:quize_game/const/text_style.dart';
import 'package:quize_game/ui/quize_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(left: width*0.07, right: width*0.07, top: height*0.04, bottom: height*0.04),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [blue, darkBlue],
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(balloon2, height: height*0.40,)),
              SizedBox(height: height*0.10,),
              normal_text(text: "Welcome to our", color: lightGray, size: 18),
              heading_text(text: "Quize App", color: Colors.white, size: 32),
              SizedBox(height: height*0.02,),
              normal_text(
                text: "Do you feel confident? Here you will face our most difficult questions!",
                size: 16,
                color: lightGray
              ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Quize_screen()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: height*0.01),
                    alignment: Alignment.center,
                    width: size.width-100,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: heading_text(text: "Continue", color: blue, size: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}