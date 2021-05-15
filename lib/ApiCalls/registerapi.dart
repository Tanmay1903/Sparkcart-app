import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants.dart';


Future registeruser(String first_name, String last_name,String username ,String email,String password) async {
  try {
    String apiUrl = domain + "/userregister/";
    final body = jsonEncode({"first_name": first_name,
      "last_name": last_name,
      "username": username,
      "email": email,
      "password": password,
    });

    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(apiUrl, headers: headers, body: body);
    if (response.statusCode == 200) {
      var convertedDatatoJson = json.decode(response.body);
      return convertedDatatoJson['message'];
    }
    if (response.statusCode == 409) {
      var resp = json.decode(response.body);
      return resp['message'];
    }
    else {
      print(response.statusCode);
    }
  }
  catch(e){
    return "internet";
  }

}

