import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/getCartApi.dart';
import 'package:sparkcart/Components/Corousel.dart';
import '../dimensions.dart';
import '../constants.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class CartCard extends StatelessWidget {
  final getDetails data;

  const CartCard({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List images = ["$domain/media/front_pic/${data.FrontPic}",
      "$domain/media/back_pic/${data.BackPic}"];
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2, horizontal: Dimensions.boxWidth*5),
      padding: EdgeInsets.all(10.0),
      height: Dimensions.boxHeight*30,
      width: Dimensions.boxWidth*100,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(color: Colors.pink[900],offset: Offset(0,10),
                blurRadius: 10
            ),
          ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 0.0),
                  constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxWidth * 25),
                  width: Dimensions.boxWidth * 25,
                  height: Dimensions.boxHeight * 18,
                  child: getNetworkCorousel(images, false)
              ),
              Container(
                constraints: BoxConstraints(maxWidth: Dimensions.boxWidth * 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                        data.product_name,
                        style: TextStyle(
                          color: Colors.pink[800],
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.boxHeight*2.2
                        ),
                      ),
                    SizedBox(height: Dimensions.boxHeight),
                    Text(
                      "Rs. ${data.Price}",
                      style: TextStyle(
                          color: Colors.pink[800],
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.boxHeight*2
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }
}

