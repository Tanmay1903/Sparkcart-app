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
                    return InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2, horizontal: Dimensions.boxWidth*5),
                        padding: EdgeInsets.all(10.0),
                        height: Dimensions.boxHeight*15,
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
                        child: Center(
                          child: Text(
                              'You have nothing in your Wishlist! Checkout some products',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Dimensions.boxHeight*3,
                              color: Colors.pink[800],
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
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
