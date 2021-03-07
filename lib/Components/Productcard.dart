import 'package:flutter/material.dart';
import '../constants.dart';
import '../dimensions.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCardComponent  extends StatelessWidget {
  final Map product;
  ProductCardComponent({this.product});

  @override
  Widget build(BuildContext context) {
    var images = ["$domain/media/front_pic/${product['FrontPic']}",
      "$domain/media/back_pic/${product['BackPic']}"];
    return Container(
      constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxHeight * 30),
      width: Dimensions.boxHeight * 27,
      height: Dimensions.boxHeight * 30,
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, '/Product_page', arguments: product);
        },
        child: Card(
          color: Colors.pink[50],
            elevation: 7.0,
            shadowColor: Colors.pink[800],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 7.0),
                  constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxHeight * 15),
                  width: Dimensions.boxHeight * 30,
                  height: Dimensions.boxHeight * 17,
                  child: Container(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          initialPage: 1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                          enlargeCenterPage: true,
                        ),
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 2.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FittedBox(
                                    child: Image(
                                        image: NetworkImage(i)
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                  ),
                ),

                SizedBox(height:5.0 ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 8.0),
                    child: Center(
                      child: Text(
                        product['product_name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.pink[900],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0,bottom: 20.0) ,
                  child: Text(
                    "Rs. ${product['Price']}",
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.pink[900],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );;
  }
}
