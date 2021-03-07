import 'package:flutter/material.dart';

Widget Description(product)
{
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Text(
          product['Description'],
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.pink[800]
        ),
      )
  );
}