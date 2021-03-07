import 'package:flutter/material.dart';
import '../constants.dart';
import '../dimensions.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCardComponent extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int i;

  ReviewCardComponent({this.snapshot,this.i});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(25.0,0.0,25.0,10.0),
      color: Colors.pink[50],
      elevation: 5.0,
      shadowColor: Colors.pink[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "${snapshot.data[i].Review_Title}",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.pink[800],
                  fontWeight: FontWeight.bold
              ),
             ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
            child: Text(
              "${snapshot.data[i].UserReview}",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.pink[800],
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Row(
              children: <Widget>[
                RatingBarIndicator(
                    rating: snapshot.data[i].UserRating,
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
                  "${snapshot.data[i].UserRating}",
                  style: TextStyle(
                      color: Colors.pink[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0,5.0,10.0,2.0),
            child: Text(
              "${snapshot.data[i].User_FirstName} ${snapshot.data[i].User_LastName}",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.pink[800],
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  size: 12.0,
                  color: Colors.grey[700],
                ),
                SizedBox(width: 2.0),
                Text(
                  "Certified Buyer",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
