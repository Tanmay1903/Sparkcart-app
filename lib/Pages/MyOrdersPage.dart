import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/getMyOrdersApi.dart';
import 'package:sparkcart/Components/OrderCard.dart';
import 'package:sparkcart/dimensions.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders"
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Dimensions.boxHeight*86,
          child: FutureBuilder(
            future: getMyOrders(),
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
                        'No Orders Placed Yet ! Checkout some products',
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
                return ListView.builder(
                    shrinkWrap: true,
                  itemCount: snapshot.data.length,
                    itemBuilder: (context,index){
                      return OrderCard(data: snapshot.data[index]);
                    });
              }
            }
          ),
        ),
      ),
    );
  }
}
