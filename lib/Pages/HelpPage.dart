import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/Components/CustomDivider.dart';
import 'package:sparkcart/dimensions.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final snackbar = SnackBar(
      content: Text(
        'Coming Soon',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimensions.boxHeight*3,
          fontWeight: FontWeight.bold,
          letterSpacing: 2
        ),
      ),
    backgroundColor: Colors.pink[800],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help Desk'
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
            child: Text(
                'Contact Us',
              style: TextStyle(
                color: Colors.pink[800],
                fontSize: Dimensions.boxHeight*6,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,top:10.0),
            child: Text(
              'Email',
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.boxHeight*3.5
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0,top: 5.0,bottom: 20.0),
            child: Text(
                'sparkcart.rtv@gmail.com',
                style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.pink[800],
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.boxHeight*3
                )
            ),
          ),
          CustomDivider(),
          InkWell(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0,top: 20.0,bottom: 20.0),
              child: Text(
                '24x7 Assistant',
                style: TextStyle(
                  color: Colors.pink[800],
                  fontSize: Dimensions.boxHeight*3,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2
                ),
              ),
            ),
          ),
          CustomDivider()
        ],
      ),
    );
  }
}
