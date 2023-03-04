import 'package:flutter/material.dart';
import 'package:quize_game/const/colors.dart';

Widget normal_text(
  {
    String? text, Color? color, double? size,
  }
){
  return Text(
    text!,
    style: TextStyle(
      fontFamily: "Quick_Font_semi",
      fontSize: size,
      color: color
    ),
  );
}


Widget heading_text(
  {
    String? text, Color? color, double? size,
  }
){
  return Text(
    text!,
    style: TextStyle(
      fontFamily: "Quick_Font_bold",
      fontSize: size,
      color: color
    ),
  );
}