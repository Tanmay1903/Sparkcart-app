import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';


final _storage = FlutterSecureStorage();


final Map<String, String> headers = {
  'Content-Type': 'application/json',

};
Future loginusers(String email, String password) async {
 try{
    String apiUrl = domain+"/userlogin/";
    final body = jsonEncode({
      "email": email,
      "password": password
    });

    final response = await http.post(apiUrl,headers: headers,body: body);
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty){
        var convertedDatatoJson = json.decode(response.body);
        updateCookie(response);
        return convertedDatatoJson;
      }

    }
    else if(response.statusCode==204) {
      return 2;
    }

    else if(response.statusCode==401) {
      return 1;
    }
    else if(response.statusCode==202){
      return 3;

    }
    else{
      print(response.statusCode);
      print(json.decode(response.body));
    }
  }catch(e)
  {
    throw "internet not connected";
  }
}


updateCookie(http.Response response) async{
  String rawCookie = response.headers['set-cookie'];

  if(rawCookie!=null){
    var token = rawCookie.split(";");
    var csfrtoken= token[0].split("=")[1];
    var sessionid=token[4].split(",")[1].split("=")[1];
     SharedPreferences prefs= await SharedPreferences.getInstance();
      var csfr = 'csfrtoken';
      var session = 'sessionid';
     await _storage.write(key: session , value: sessionid);
     await _storage.write(key: csfr, value: csfrtoken);

    final all = await _storage.readAll();
  }
  else
    print("no rawcookies");
}


