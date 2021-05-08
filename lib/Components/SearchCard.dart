import 'package:flutter/material.dart';
import '../dimensions.dart';
import '../constants.dart';
import '../Components/Corousel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SearchCard extends StatelessWidget {
  final data;

  const SearchCard({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List images = ["$domain/media/front_pic/${data["FrontPic"]}",
      "$domain/media/back_pic/${data["BackPic"]}"];
    final double price = data["Price"] - data["Discount"];
    var percentage = ((data['Discount']/data['Price'])*100).round();
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*2, horizontal: Dimensions.boxWidth*3),
      padding: EdgeInsets.all(10.0),
      height: Dimensions.boxHeight*25,
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
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 0.0),
              constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxWidth *25),
              width: Dimensions.boxWidth * 25,
              height: Dimensions.boxHeight * 18,
              child: getNetworkCorousel(images, false)
          ),
          Container(
            constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 18,maxWidth: Dimensions.boxWidth * 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    data["product_name"].split('-')[0],
                    style: TextStyle(
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.boxHeight*2.7
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        "Rs. ${price}",
                        style: TextStyle(
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.boxHeight*2.5
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${data['Price']}",
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
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        RatingBarIndicator(
                            rating: data['OverallRating'],
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: Dimensions.boxHeight*3,
                            itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.pink[800]
                            )
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "${data['OverallRating']}",
                          style: TextStyle(
                              color: Colors.pink[900],
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.boxHeight*2.3
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
