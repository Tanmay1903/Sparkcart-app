import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sparkcart/ApiCalls/getCartApi.dart';
import 'package:sparkcart/Components/CartCard.dart';
import 'package:sparkcart/Pages/BuyNowPage.dart';
import '../dimensions.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<dynamic> data;
  double total_price = 0;
  double calculate_price;

  @override
  Widget build(BuildContext context) {
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
                calculate_price = 0;
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
                          'You have nothing in your Cart! Checkout some products',
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
                          var price = snapshot.data[index].Price - snapshot.data[index].Discount ;
                          calculate_price += snapshot.data[index].Quantity * price;
                          try {
                            SchedulerBinding.instance
                                .addPostFrameCallback((_) =>
                                setState(() {
                                  total_price = calculate_price;
                                }));
                          }
                          catch(e){
                            print('1');
                          }
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
      bottomNavigationBar: Container(
        height: Dimensions.boxHeight*10,
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        color: Colors.pink[800],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: Dimensions.boxHeight*2
                    ),
                  ),
                  Text(
                    'Rs. ${total_price}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: Dimensions.boxHeight*2.8
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BuyNow()));
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: Dimensions.boxWidth*30,
                  height: Dimensions.boxHeight*7,
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(Dimensions.boxHeight * 5)
                  ),
                  child: Center(
                    child: Text(
                          'Buy Now',
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontSize: Dimensions.boxHeight*2.5
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
