import 'package:flutter/material.dart';

Widget AppBarComponent(){
  return (
      AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: (){},
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.shopping_cart)
              ),
            )
          ]
      )
  );
}