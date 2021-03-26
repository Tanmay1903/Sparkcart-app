import 'package:http/http.dart';
import 'dart:convert';
import '../constants.dart';

Map<String,dynamic> amazon;
Map<String,dynamic> flipkart;

class sentiment{
  String amaz_name = '';
  String amaz_price = '' ;
  double amaz_perc = 0.0;
  double amaz_acc = 0.0;
  String flip_name = '';
  String flip_price = '';
  double flip_perc = 0.0;
  String amaz_mess = '';
  String flip_mess = '';
  sentiment({this.amaz_name,this.amaz_price,this.amaz_perc,this.amaz_acc,this.flip_name,this.flip_price,this.flip_perc,this.amaz_mess,this.flip_mess});

}
sentiment s = sentiment();
sentiment getSentiment(){
  return s;
}

Future<void> getAnalysis(id) async {
 try{
    Response response;
    response = await get('$domain/sentimentamazon/$id');
    if (response.statusCode ==200) {
      amazon = jsonDecode(response.body);
      if (amazon['Amazon'].containsKey('message')){
          s.amaz_mess = amazon['Amazon']['message'];
      }
      else{
        s.amaz_name = amazon['Amazon']['Name'];
        s.amaz_price = amazon['Amazon']['Price'];
        s.amaz_perc = amazon['Amazon']['Percentage'];
        s.amaz_acc = amazon['Amazon']['Accuracy'];
        s.amaz_mess = "";
      }
    }
    response = await get('$domain/sentimentflipkart/$id');
    if (response.statusCode ==200) {
      flipkart = jsonDecode(response.body);
      if (flipkart['Flipkart'].containsKey('message')){
        s.flip_mess = flipkart['Flipkart']['message'];
      }
      else{
        s.flip_name = flipkart['Flipkart']['Name'];
        s.flip_price = flipkart['Flipkart']['Price'];
        s.flip_perc = flipkart['Flipkart']['Percentage'];
        s.flip_mess = "";
      }
    }
    return ;
  }
  catch(e){
    print("internet");
  }
}
