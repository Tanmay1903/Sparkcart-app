import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sparkcart/Pages/LoginPage.dart';
import 'package:sparkcart/Pages/SentimentAnalysisPage.dart';
import 'Pages/Homepage.dart';
import 'Pages/Productpage.dart';
import 'constants.dart';
import 'package:http/http.dart';
import 'Pages/ProfilePage.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Sparkcart app',
    theme: ThemeData(
        primaryColor: Color(kdark),
        canvasColor: Colors.pink[50],
        backgroundColor: Color(klight),
        accentColor: Color(klight)
    ),
  //initialRoute: '/home',
  routes:{
    '/' : (context) => Loading(),
    '/home' : (context) => HomePage(),
    '/login': (context) => LoginPage(),
    '/Product_page': (context) => ProductPage(),
    '/profile': (context) => ProfilePage(),
    '/sentiment_analysis': (context) => SentimentAnalysis(),
  }
));

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getProducts() async {
    Response response = await get('$domain/product_list/');
    List<dynamic> data = jsonDecode(response.body);
    Navigator.pushReplacementNamed(context, '/home', arguments: data);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Text(
          'Loading Screen'
        ),
      )
    );
  }
}

