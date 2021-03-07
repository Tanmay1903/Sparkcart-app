import 'package:http/http.dart';
import 'dart:convert';
import '../constants.dart';

Future<dynamic> getReviews(product) async {
  try{
    String apiUrl = domain+"/getreview/";
    final body = jsonEncode({"Productid": "${product['Productid']}"});

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    final response = await post(apiUrl,headers: headers,body: body);
    if (response.statusCode ==200) {
      var jsonData = json.decode(response.body);
      List<Review> reviewlist = [];
      for(var u in jsonData){
        reviewlist.add(Review(
            User_FirstName: u["User_FirstName"],
            User_LastName: u["User_LastName"],
            Review_Title: u["Review_Title"],
            UserRating: u["UserRating"],
            UserReview: u["UserReview"]));
      }
      return reviewlist;
    }
    else if(response.statusCode==204){

      var jsonData = json.decode(response.body);
      print(jsonData['message']);
      print(1);
      return jsonData['message'];
    }
  }catch(e){
    return "internet";
  }
}

class Review {

  final String User_FirstName;
  final String User_LastName;
  final String Review_Title;
  final double UserRating;
  final String UserReview;


  Review( {this.User_FirstName, this.User_LastName,  this.Review_Title,this.UserRating, this.UserReview});}