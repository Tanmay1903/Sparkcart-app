import 'package:flutter/cupertino.dart';

class Dimensions{
  static double boxWidth;
  static double boxHeight;
  Dimensions(BuildContext context){
    boxWidth=MediaQuery.of(context).size.width/100;
    boxHeight=MediaQuery.of(context).size.height/100;
  }
}