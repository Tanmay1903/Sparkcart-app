import 'package:flutter/material.dart';
import '../Pages/CartPage.dart';
import '../Pages/WishlistPage.dart';


Widget AppBarComponent(BuildContext context,bool isLoggedIn){
  return (
      AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: (){
                isLoggedIn?
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => WishlistPage()))
                    :
                Navigator.pushNamed(context, '/login');
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
              child: IconButton(
                  onPressed: (){
                    isLoggedIn?
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => CartPage()))
                        :
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: Icon(Icons.shopping_cart)
              ),
            )
          ]
      )
  );
}