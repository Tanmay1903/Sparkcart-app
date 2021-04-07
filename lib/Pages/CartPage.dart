import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/getCartApi.dart';
import 'package:sparkcart/Components/CartCard.dart';
import '../dimensions.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<dynamic> data;
  @override
  Widget build(BuildContext context) {
    data = getCart();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(
            letterSpacing: 2
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
              future: getCart(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if (snapshot.data == '204') {
                  return Container(
                    child: Text(
                      'You have nothing in your Cart!'
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
                          return CartCard(data: snapshot.data[index]);
                          }
                      )
                  );
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
