import 'dart:convert';

import 'package:flutter/material.dart';
import 'Pages/Homepage.dart';
import 'constants.dart';
import 'package:http/http.dart';

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
    '/home' : (context) => HomePage()
  }
));

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getProducts() async {
    Response response = await get('$domain/spkct/product_list/');
    //print(response.body);
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

