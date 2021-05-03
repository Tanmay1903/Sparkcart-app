import 'package:flutter/material.dart';

SnackBar getSnackBar(String text){
  return SnackBar(
    duration: Duration(seconds: 2),
    content: Text(
      text,
      style: TextStyle(
        fontSize: 15,
        letterSpacing: 2,
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),
    ),
    backgroundColor: Colors.pink[800],
  );
}