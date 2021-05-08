import 'package:flutter/foundation.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final Map<String, String> headers = {
  'Content-Type': 'application/json',
};

Future SearchCategory(String Category, String Key) async {
  String apiUrl;
  if(Key == "Category") {
     apiUrl = domain + "/searchproduct/";
  }
  else if(Key == "Search"){
    apiUrl = domain + "/search/";
  }
  final body = jsonEncode({
    Key: Category
  });

  final response = await http.post(apiUrl,headers: headers,body: body);
  if (response.statusCode == 200){
    List<dynamic> data = jsonDecode(response.body);
    return data;
  }
  else if(response.statusCode == 204){
    return '204';
  }
  else {
    return '400';
  }
}