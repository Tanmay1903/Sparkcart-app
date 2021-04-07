import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../dimensions.dart';

Widget getCorousel(List imageurls){
  return CarouselSlider(
    options: CarouselOptions(
      height: 200.0,
      initialPage: 1,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
      enlargeCenterPage: true,
    ),
    items: imageurls.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FittedBox(
                child: Image(
                    image: AssetImage(i)
                ),
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}

Widget getNetworkCorousel(List images,bool flag){
  return CarouselSlider(
    options: CarouselOptions(
      height: Dimensions.boxHeight*50,
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
                fit: flag ? BoxFit.fitHeight : BoxFit.fill,
              ),
            ),
          );
        },
      );
    }).toList(),
  );
}



