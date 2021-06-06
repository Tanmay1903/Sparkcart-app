import 'package:flutter/material.dart';
import 'package:sparkcart/Components/Corousel.dart';
import 'package:sparkcart/dimensions.dart';
import 'package:sparkcart/constants.dart';

class OrderCard extends StatefulWidget {
  final data;

  const OrderCard({Key key, this.data}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    List images = [];
    List names = [];
    for(var u in widget.data['Productid']){
      images.add("$domain/media/front_pic/${u['FrontPic']}");
      images.add("$domain/media/back_pic/${u['BackPic']}");
      names.add(u["product_name"]);
    }
    return Container(
      margin: EdgeInsets.fromLTRB(Dimensions.boxWidth*2,Dimensions.boxHeight*2, Dimensions.boxWidth*2,Dimensions.boxHeight),
      padding: EdgeInsets.all(10.0),
      height: Dimensions.boxHeight*25,
      width: Dimensions.boxWidth*100,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(color: Colors.pink[900],offset: Offset(0,5),
                blurRadius: 3
            ),
          ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: Dimensions.boxWidth*2.2),
              Text(
                "TRACKING NUMBER :- ",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: Dimensions.boxHeight*1.8
                ),
              ),
              Text(
                "${widget.data["Tracking_Number"]}",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: Dimensions.boxHeight*1.8
                ),
              )
            ],
          ),
          SizedBox(height: Dimensions.boxHeight*0.5),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 0.0),
                  constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxWidth * 25),
                  width: Dimensions.boxWidth * 25,
                  height: Dimensions.boxHeight * 18,
                  child: getNetworkCorousel(images, false)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.data['status'] + " on " + widget.data["Order_date"].split(" ")[0],
                    style: TextStyle(
                      color: Colors.pink[800],
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.boxHeight*2.3
                    ),
                  ),
                  SizedBox(height: Dimensions.boxHeight*2),
                  Container(
                    width: Dimensions.boxWidth*60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: names.map((name) {
                      return Container(
                        child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.boxHeight*2.3
                        ),
                    ),
                      );}
                    ).toList(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
