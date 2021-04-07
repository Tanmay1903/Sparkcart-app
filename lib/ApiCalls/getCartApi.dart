import 'dart:convert';
import '../constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:io';

final _storage = FlutterSecureStorage();

class getDetails{
  final int Productid;
  final String product_name;
  final String Description;
  final int Quantity;
  final double Price;
  final String Category;
  final double Discount;
  final String Brand;
  final String Model;
  final String FrontPic;
  final String BackPic;

  getDetails(this.Productid, this.product_name, this.Description, this.Quantity, this.Price, this.Category, this.Discount, this.Brand, this.Model, this.FrontPic, this.BackPic);

}

Future getCart() async {
  try
  {
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(domain + "/getcart/"));
  final all = await _storage.readAll();
  request.cookies.add(Cookie("csrftoken", all['csfrtoken']));
  request.cookies.add(Cookie("sessionid", all['sessionid']));

  request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
  request.headers.set('x-csrftoken', all['csfrtoken']);
  request.headers.set('referer', "http://159.65.157.59/");
  final response = await request.close();
  if(response.statusCode == 200){
    var temp;
    List<getDetails> getD = [];
    await response.transform(Utf8Decoder()).listen((value) {}).onData((data) {
      temp = json.decode(data);
    });
    for ( var u in temp){
      getD.add(getDetails(
          u['Productid'],
          u['product_name'],
          u['Description'],
          u['Quantity'],
          u['Price'],
          u['Category'],
          u['Discount'],
          u['Brand'],
          u['Model'],
          u['FrontPic'],
          u['BackPic']
      ));
    }
    getD = getD.reversed.toList();
    return getD;
  }
  else if(response.statusCode==204){
    return '204';
  }
  else {
    print("Try again");
    return null;
  }
  }catch(e){
  print(e);

  }

}