import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/getCartApi.dart';
import 'package:sparkcart/Components/WishlistCard.dart';
import '../dimensions.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: TextStyle(
              letterSpacing: 2
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
                future: getWishlist(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.data == '204') {
                    return Container(
                      child: Text(
                          'You have nothing in your Wishlist!'
                      ),
                    );
                  }
                  else if(snapshot.data == null){
                    return Container(
                      margin: EdgeInsets.all(Dimensions.boxHeight * 13),
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.pink[800],
                      ),
                    );
                  }
                  else{
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                          return WishlistCard(data: snapshot.data[index]);
                          }
                      ),
                    );
                  }
                }
            ),
          )
        ],
      ),
    );
  }
}
