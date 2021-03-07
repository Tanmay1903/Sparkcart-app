import 'package:flutter/material.dart';

Widget MoreInfo(product){
  Map data = product['manufacturing_details'][0];
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0,bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex:4,
                child: Text(
                  "Model No.",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                flex:5,
                child: Text(
                  "${data['Model_no']}",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                flex:4,
                child: Text(
                  "Release Date",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(
                flex:5,
                child: Text(
                  "${data['Release_date']}",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
