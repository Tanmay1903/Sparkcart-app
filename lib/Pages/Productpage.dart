import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sparkcart/Components/ReviewCard.dart';
import 'package:sparkcart/Components/CustomDivider.dart';
import 'package:sparkcart/Components/AllReview.dart';
import 'package:sparkcart/Pages/ProductDetail.dart';
import '../constants.dart';
import '../ApiCalls/getReview.dart';
import '../dimensions.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var isFav = false;
  Future<dynamic> data ;

  @override
  Widget build(BuildContext context) {
    Map product = ModalRoute.of(context).settings.arguments;
    data = getReviews(product);
    var price = product['Price'] - product['Discount'];
    var percentage = ((product['Discount']/product['Price'])*100).round();
    var images = ["$domain/media/front_pic/${product['FrontPic']}",
      "$domain/media/back_pic/${product['BackPic']}"];
    return Scaffold(
      appBar: AppBar(
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
        ]
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                    margin: EdgeInsets.all(10.0),
                      child: CarouselSlider(
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
                                  borderRadius: BorderRadius.circular(25),
                                  child: FittedBox(
                                    child: Image(
                                        image: NetworkImage(i)
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                  ),
                    Positioned(
                      top: 20.0,
                      left: 340.0,
                      child: FloatingActionButton(
                        heroTag: "btn1",
                        elevation: 10.0,
                        child: IconButton(
                          icon: Icon(
                              isFav ? Icons.favorite: Icons.favorite_border,
                            color: Colors.pink[800],
                          ),
                          onPressed: (){
                            setState(() {
                              isFav = !isFav;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 90.0,
                      left: 340.0,
                      child: FloatingActionButton(
                        heroTag: "btn2",
                        elevation: 10.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.pink[800],
                          ),
                          onPressed: (){},
                        ),
                      ),
                    )
                ]),
                CustomDivider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,10.0,0.0,0.0),
                  child: Text(
                    product['Brand'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      fontStyle: FontStyle.italic
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,10.0,0.0,0.0),
                  child: Text(
                      product['product_name'],
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,10.0,0.0,0.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "₹ $price",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink[800]
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${product['Price']}",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                          decoration: TextDecoration.lineThrough
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "$percentage % Off",
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
                Container(
                  margin: EdgeInsets.only(left: 20.0,top: 5.0),
                  child: Row(
                    children: <Widget>[
                      RatingBarIndicator(
                          rating: product['OverallRating'],
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                              Icons.star,
                            color: Colors.pink[800]
                            )
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${product['OverallRating']}",
                        style: TextStyle(
                          color: Colors.pink[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                CustomDivider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,10.0,20.0,0.0),
                  child: Text(
                    product['Description'],
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pink[900],
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                CustomDivider(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60.0,vertical: 10.0),
                  child: FloatingActionButton.extended(
                    elevation: 7.0,
                    isExtended: true,
                    backgroundColor: Colors.pink[800],
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "Sentiment Analysis",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                CustomDivider(),
                Container(
                  margin: EdgeInsets.fromLTRB(20.0,10.0,20.0,0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Product Details",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.pink[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:2,
                              child: Text(
                                "Brand",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Text(
                                product["Brand"],
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:2,
                              child: Text(
                                "Model",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Text(
                                product["Model"],
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:2,
                              child: Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Text(
                                product["Category"],
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.pink[800],
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right:40.0,bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                              builder: (context) => ProductDetail(product: product),
                              ),
                          );
                        },
                        child: Text(
                            "All Details >",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.pink[800],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                CustomDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  child: Text(
                    "Reviews",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                FutureBuilder(
                  future: data,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.data==204){
                      return Container(
                        child: Center(
                          child: Text("No reviews available for this product"),
                        ),
                      );
                    }
                    else if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*8),
                              child: Center(child: CircularProgressIndicator(backgroundColor: Color(kdark)))
                          ),
                        ),//
                      );
                    }
                    else if(snapshot.data == "internet"){
                      return Container(
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight*8),
                              child:Text(
                                "Reviews not available",style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: Dimensions.boxHeight * 2.5
                              ),
                              )
                          ),
                        ),//

                      );
                    }
                    else{
                      return CustomScrollView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        slivers: <Widget>[
                          SliverList(
                          delegate: SliverChildBuilderDelegate((BuildContext context,int index) {
                            if (index>3) return null;
                            return ReviewCardComponent(snapshot: snapshot, i: index);
                          },
                            childCount: (snapshot.data.length>3)? 3:snapshot.data.length,

                          ),
                        ),
                        ]
                      );
//                        ListView.builder(
//                          shrinkWrap: true,
//                          itemCount: (snapshot.data.length>4) ? 4 : snapshot.data.length,
//                          itemBuilder: (context,index){
//                          return ReviewCardComponent(snapshot:snapshot,i:index);
//                          }
//                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, right:40.0,bottom: 5.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => AllReview(reviews: data),
                            ),
                          );
                        },
                        child: Text(
                          "All Reviews >",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.pink[800],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex:1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink[800]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: FlatButton(
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: (){},
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.pink[800],
                  border: Border.all(color: Colors.pink[800]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: FlatButton(
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: (){},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}