import 'package:flutter/material.dart';
import 'package:sparkcart/dimensions.dart';

class OrderPlacedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Dimensions.boxHeight*10),
          Row(
            children: [
              SizedBox(width: Dimensions.boxWidth*4),
              FloatingActionButton(
                  elevation: 15.0,
                  child: Icon(
                    Icons.home,
                    color: Colors.pink[800],
                    size: Dimensions.boxHeight*5,
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/');
                  } ),
            ],
          ),
          SizedBox(height: Dimensions.boxHeight*10),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: Dimensions.boxHeight*20,
                  color: Colors.pink[800],
                ),
                SizedBox(height: Dimensions.boxHeight*2,),
                Text(
                  'Order Confirmed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink[800],
                    fontSize: Dimensions.boxHeight*5,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Thank You for Shopping With Us! Continue Shopping!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.pink[800],
                        fontSize: Dimensions.boxHeight*4
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.boxHeight*6),
          InkWell(
            onTap: (){
              Navigator.pushReplacementNamed(context, '/myorders');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.pink[800],
                border: Border.all(color: Colors.pink[800]),
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.boxWidth*2)),
              ),
              child: Text(
                "My Orders",
                style: TextStyle(
                    fontSize: Dimensions.boxHeight*2.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
