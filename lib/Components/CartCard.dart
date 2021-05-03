import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/getCartApi.dart';
import 'package:sparkcart/ApiCalls/removeFromCartApi.dart';
import 'package:sparkcart/Components/Corousel.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:sparkcart/Pages/CartPage.dart';
import '../dimensions.dart';
import '../constants.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class CartCard extends StatelessWidget {
  final getDetails data;

  const CartCard({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List images = ["$domain/media/front_pic/${data.FrontPic}",
      "$domain/media/back_pic/${data.BackPic}"];
    final double price = data.Price - data.Discount;
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2, horizontal: Dimensions.boxWidth*5),
      padding: EdgeInsets.all(10.0),
      height: Dimensions.boxHeight*30,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
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
                          data.product_name.split('-')[0],
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
                              value: data.Quantity.toDouble(),
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
          SizedBox(height: Dimensions.boxHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  var status = await removeFromCart(data.Productid);
                  SnackBar snackbar;
                  if(status == 200){
                    snackbar = getSnackBar('Product Removed From Cart');
                  }
                  else if(status == 404){
                    snackbar = getSnackBar('Product already removed!');
                  }
                  else{
                    snackbar = getSnackBar('Some Unknown Error from backend');
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: Dimensions.boxWidth*30,
                  height: Dimensions.boxHeight*5.5,
                  decoration: BoxDecoration(
                      color: Colors.pink[800],
                      borderRadius: BorderRadius.circular(Dimensions.boxHeight * 5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: Dimensions.boxHeight*2.5,
                      ),
                      SizedBox(width: Dimensions.boxWidth),
                      Text(
                        'Remove',
                        style: TextStyle(
                            color: Colors.white,
                          fontWeight: FontWeight.values[4],
                          letterSpacing: 2,
                          fontSize: Dimensions.boxHeight*2
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: Dimensions.boxWidth*43,
                height: Dimensions.boxHeight*5.5,
                decoration: BoxDecoration(
                    color: Colors.pink[800],
                    borderRadius: BorderRadius.circular(Dimensions.boxHeight * 5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.archive,
                      color: Colors.white,
                      size: Dimensions.boxHeight*2.5,
                    ),
                    SizedBox(width: Dimensions.boxWidth),
                    Text(
                      'Save for Later',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.values[4],
                          letterSpacing: 2,
                          fontSize: Dimensions.boxHeight*2
                      ),
                    ),
                  ],
                ),
              ),

//              FloatingActionButton.extended(
//                onPressed: (){},
//                elevation: 10.0,
//                isExtended: true,
//                backgroundColor: Colors.pink[800],
//                label: Row(
//                  children: [
//                    Icon(
//                      Icons.archive,
//                      color: Colors.white,
//                    ),
//                    SizedBox(width: Dimensions.boxWidth*2),
//                    Text(
//                      'Save for Later',
//                      style: TextStyle(
//                          color: Colors.white
//                      ),
//                    ),
//                  ],
//                ),
//              )
            ],
          )
        ],
      )
    );
  }
}

