import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../dimensions.dart';
import 'package:sparkcart/Components/ReviewCard.dart';

class AllReview extends StatelessWidget {
  final Future<dynamic> reviews;
  AllReview({this.reviews});
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: <Widget>[
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
                future: reviews,
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
                    return
//                      CustomScrollView(
//                        scrollDirection: Axis.vertical,
//                        shrinkWrap: true,
//                        slivers: <Widget>[
//                          SliverList(
//                            delegate: SliverChildBuilderDelegate((BuildContext context,int index) {
//                              if (index>3) return null;
//                              return ReviewCardComponent(snapshot: snapshot, i: index);
//                            },
//                              childCount: snapshot.data.length,
//
//                            ),
//                          ),
//                        ]
//                    );
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                          return ReviewCardComponent(snapshot:snapshot,i:index);
                          }
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
