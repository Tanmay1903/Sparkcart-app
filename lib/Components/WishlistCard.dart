import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkcart/ApiCalls/getCartApi.dart';
import 'package:sparkcart/ApiCalls/removeFromCartApi.dart';
import 'package:sparkcart/Pages/WishlistPage.dart';
import '../dimensions.dart';
import '../constants.dart';
import 'package:sparkcart/Components/Corousel.dart';
import 'package:sparkcart/Components/getSnackbar.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WishlistCard extends StatefulWidget {
  final getDetails data;

  const WishlistCard({Key key, this.data}) : super(key: key);

  @override
  _WishlistCardState createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  void getProduct(BuildContext context, int id) async {
    try {
      Response response = await get('$domain/get_product/$id');
      Map product = jsonDecode(response.body);
      Navigator.pushReplacementNamed(context, '/Product_page', arguments: product);
    }
    catch(e){
      SnackBar snackBar = getSnackBar("Please Check Your Internet Connection");
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List images = ["$domain/media/front_pic/${widget.data.FrontPic}",
      "$domain/media/back_pic/${widget.data.BackPic}"];
    var percentage = ((widget.data.Discount/widget.data.Price)*100).round();
    final double price = widget.data.Price - widget.data.Discount;
    return InkWell(
      onTap: (){
        getProduct(context, widget.data.Productid);
      },
      child: Container(
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
                    constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 17,maxWidth: Dimensions.boxWidth * 54),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.data.product_name.split('-')[0],
                            style: TextStyle(
                                color: Colors.pink[800],
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.boxHeight*2.7
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.data.Brand,
                            style: TextStyle(
                                fontSize: Dimensions.boxHeight*2.2,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Text(
                                "Rs.${price}",
                                style: TextStyle(
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.boxHeight*2.5
                                ),
                              ),
                              SizedBox(width: Dimensions.boxWidth*0.9),
                              Text(
                                "${widget.data.Price}",
                                style: TextStyle(
                                    fontSize: Dimensions.boxHeight*2,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[700],
                                    decoration: TextDecoration.lineThrough
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "$percentage% Off",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                                color: Colors.pink[800],
                              )
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
                        var status = await removeFromWishlist(widget.data.Productid);
                        SnackBar snackbar;
                        if(status == 200){
                          snackbar = getSnackBar('Product Removed From Wishlist');
                        }
                        else if(status == 404){
                          snackbar = getSnackBar('Product already removed!');
                        }
                        else{
                          snackbar = getSnackBar('Some Unknown Error from backend');
                        }
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WishlistPage()));
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
                            'Buy Now',
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
                ]
              ),
            ]
        ),
      ),
    );
  }
}
