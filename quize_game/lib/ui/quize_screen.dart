import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quize_game/const/api_service.dart';
import 'package:quize_game/const/colors.dart';
import 'package:quize_game/const/images.dart';
import 'package:quize_game/const/text_style.dart';
import 'package:quize_game/ui/homepage.dart';

class Quize_screen extends StatefulWidget {
  const Quize_screen({super.key});

  @override
  State<Quize_screen> createState() => _Quize_screenState();
}

class _Quize_screenState extends State<Quize_screen> {
  @override
  int second = 60;

  Timer? timer;
  var current_QuestionNumber = 0;
  late Future Quiz;

  var isloaded = false;

  var optionList = [];
  int points = 0;

  var optionColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  void initState() {
    super.initState();
    Quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (second > 0) {
          second--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  resetColor() {
    optionColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  next_Question() {
    isloaded = false;
    current_QuestionNumber++;
    resetColor();
    timer!.cancel();
    second = 60;
    startTimer();
  }

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
          padding: EdgeInsets.only(
              left: width * 0.07,
              right: width * 0.07,
              top: height * 0.04,
              bottom: height * 0.04),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [blue, darkBlue],
          )),
          child: FutureBuilder(
              future: Quiz,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data['results'];

                  if (isloaded == false) {
                    optionList =
                        data[current_QuestionNumber]['incorrect_answers'];
                    optionList
                        .add(data[current_QuestionNumber]['correct_answer']);
                    optionList.shuffle();
                    isloaded = true;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(color: lightGray, width: 2)),
                                child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "ALert!",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                              content: Text(
                                                  "are you sure? you want to exit."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Homepage(
                                                                        title:
                                                                            'Homepage',
                                                                      ),),),
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      CupertinoIcons.xmark,
                                      color: Colors.white,
                                      size: 28,
                                    )),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  normal_text(
                                      text: "$second",
                                      size: 22,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      value: second / 60,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          ideas,
                          width: width*0.40,
                          height: height*0.25,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: normal_text(
                            text:
                                "Question ${current_QuestionNumber + 1} of ${data.length}",
                            color: lightGray,
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        normal_text(
                            text: data[current_QuestionNumber]['question'],
                            color: Colors.white,
                            size: 20),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: optionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var answer = data[current_QuestionNumber]
                                  ['correct_answer'];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answer.toString() ==
                                        optionList[index].toString()) {
                                      optionColor[index] = Colors.green;
                                      points = points + 5;
                                    } else {
                                      optionColor[index] = Colors.red;
                                    }
                                    if (current_QuestionNumber <
                                        data.length - 1) {
                                      Future.delayed(
                                          Duration(seconds: 1), () {
                                            next_Question();
                                          });
                                    } else {
                                      timer!.cancel();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Points",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                              content: Text(
                                                  "Your points is $points"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Homepage(
                                                                    title:
                                                                        'Homepage',
                                                                  ))),
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.01),
                                  alignment: Alignment.center,
                                  width: size.width - 100,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: optionColor[index],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: heading_text(
                                      text: optionList[index].toString(),
                                      color: blue,
                                      size: 18),
                                ),
                              );
                            })
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                }
              })),
    ));
  }
}
