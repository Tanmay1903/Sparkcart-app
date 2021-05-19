
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkcart/Components/CustomDivider.dart';
import 'package:sparkcart/dimensions.dart';
import 'package:sparkcart/Components/Corousel.dart';
import '../constants.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class BuyNow extends StatefulWidget {
  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  List<dynamic> products = [];
  List address = [];
  double total_price = 0.0;
  double discount = 0.0;
  double payable = 0.0;
  check_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getStringList('address');
    });
  }
  Widget getAddressCard(){
    if((address.isNotEmpty && address[0] == "") || address.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            size: Dimensions.boxHeight*4,
            color: Colors.pink[900],
          ),
          Text(
            ' Add an Address',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.boxHeight*3,
              color: Colors.pink[800]
            ),
          )
        ],
      );
    }
    else if(address.isNotEmpty){
      return Icon(
        Icons.check_circle_outline,
        color: Colors.pink[800],
        size: Dimensions.boxHeight*5,
      );
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_user();
  }
  @override
  Widget build(BuildContext context) {
    products = ModalRoute.of(context).settings.arguments;
    var counter = products.length > 2? 2 :products.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: TextStyle(
            letterSpacing: 2
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/25,vertical: MediaQuery.of(context).size.height/50),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(Dimensions.boxHeight * 2),
                    boxShadow: [
                      BoxShadow(color: Colors.pink[900],offset: Offset(0,3),
                          blurRadius: 10
                      ),
                    ]
                ),
                child: getAddressCard()
              ),
              Container(
                height: Dimensions.boxHeight*30*counter,
                child: ListView.builder(
                  itemCount: products.length,
                    itemBuilder: (context,index){
                      var images = ["$domain/media/front_pic/${products[index]['FrontPic']}",
                        "$domain/media/back_pic/${products[index]['BackPic']}"];
                      double price = products[index]["Price"] - products[index]["Discount"];
                      if (index == 0){
                        total_price = products[index]['Price'];
                        discount = products[index]['Discount'];
                        payable = price;
                      }
                      else {
                      total_price = total_price + products[index]['Price'];
                      discount = discount+ products[index]['Discount'];
                      payable = payable + price;
                      }
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight, horizontal: Dimensions.boxWidth*3),
                    padding: EdgeInsets.all(10.0),
                    height: Dimensions.boxHeight*27,
                    width: Dimensions.boxWidth*100,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(color: Colors.pink[900],offset: Offset(0,3),
                              blurRadius: 10
                          ),
                        ]
                    ),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 0.0),
                            constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxWidth * 25),
                            width: Dimensions.boxWidth * 25,
                            height: Dimensions.boxHeight * 18,
                            child: getNetworkCorousel(images, false)
                        ),
                        Container(
                          constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 17,maxWidth: Dimensions.boxWidth * 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  products[index]["product_name"].split('-')[0],
                                  style: TextStyle(
                                      color: Colors.pink[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.boxHeight*2.2
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.boxHeight),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Rs. ${price}",
                                  style: TextStyle(
                                      color: Colors.pink[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.boxHeight*2
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Text(
                                      'Qty: ',
                                      style: TextStyle(
                                          fontSize: Dimensions.boxHeight*2,
                                          color: Colors.pink[800],
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(maxWidth: Dimensions.boxWidth * 27),
                                      child: SpinBox(
                                        min: 0,
                                        max: 10,
                                        spacing: 0,
                                        decoration: InputDecoration(
                                            border: InputBorder.none
                                        ),
                                        incrementIcon: Icon(
                                            Icons.add,
                                            size: Dimensions.boxHeight*2.5,
                                            color: Colors.pink[800]
                                        ),
                                        decrementIcon: Icon(
                                            Icons.remove,
                                            size: Dimensions.boxHeight*2.5,
                                            color: Colors.pink[800]
                                        ),
                                        value: products[index]["Quantity"] != null? products[index]["Quantity"]:1  ,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
              CustomDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 7.0),
                child: Text(
                  "Summary",
                  style: TextStyle(
                      color: Colors.pink[800],
                      fontSize: Dimensions.boxHeight*3.5,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              CustomDivider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 7.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Total Price",
                          style: TextStyle(
                            color: Colors.pink[800],
                            fontSize: Dimensions.boxHeight*2.5,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Rs. ${total_price}",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.boxHeight,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Discount",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Rs. ${discount}",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.boxHeight,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Charges",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Free",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.boxHeight,),
                    CustomDivider(),
                    SizedBox(height: Dimensions.boxHeight,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount Payable",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Rs. ${payable}",
                          style: TextStyle(
                              color: Colors.pink[800],
                              fontSize: Dimensions.boxHeight*2.5,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.boxHeight,),
                    CustomDivider()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
