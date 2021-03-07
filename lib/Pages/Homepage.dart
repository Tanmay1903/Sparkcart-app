import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../dimensions.dart';
import 'dart:math';
import '../Components/Productcard.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];
  var imageurls = [
    'assets/offer1.jfif',
    'assets/offer2.jpg',
    'assets/offer4.jfif'
  ];
  var categories = [
    'Electronics',
    'Men',
    'Women',
    'Furniture',
    'TVs & Appliances',
    'Sports',
    'Babies & Kids',
    'Others'
  ];
  final _random = new Random();
  dynamic product;
  Widget ProductCard() {
    return Container(
      constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 30,maxWidth: Dimensions.boxHeight * 60),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      height: Dimensions.boxHeight * 30,
      width: Dimensions.boxHeight * 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index){
          product = products[_random.nextInt(products.length)];
          return ProductCardComponent(product:product);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Dimensions(context);
    products = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: (){},
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: <Widget>[
            Text('Sparkcart'),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.mic),
              onPressed: (){},
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
            child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.shopping_cart)
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            height: 40.0,
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            //padding: const EdgeInsets.only(top:10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Material(
                color: Colors.grey[300],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.search,color: Colors.grey),
                    Expanded(
                      child: TextField(
                        // textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: ' Search by name or category',
                        ),
                        onChanged: (value) {

                        },
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.mic,color: Colors.grey,),
                      onTap: () {

                      },
                    )
                  ],
                ),
              ),
            )
        ) ,
      ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
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
                )
            ),
            SizedBox(height: 20.0),
            ProductCard(),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: Dimensions.boxHeight * 10,maxWidth: Dimensions.boxWidth * 100),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  height: Dimensions.boxHeight * 10,
                  width: Dimensions.boxWidth * 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CircleAvatar(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          radius: 30.0,
                          backgroundColor: Colors.pink[800],
                          //backgroundImage: AssetImage('assets/electronics.jfif'),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
            SizedBox(height: 10.0),
            ProductCard()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text('Wishlist'),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          )
        ],
        selectedItemColor: Colors.pink[800],
      ),
    );
  }
}
