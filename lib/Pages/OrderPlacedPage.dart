import 'package:flutter/material.dart';
import 'package:sparkcart/dimensions.dart';

class OrderPlacedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
