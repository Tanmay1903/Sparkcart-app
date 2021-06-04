import 'dart:convert';
import '../constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

final _storage = FlutterSecureStorage();

Future getMyOrders() async {
  try{
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(domain + "/getmyorders/"));
  final all = await _storage.readAll();
  request.cookies.add(Cookie("csrftoken", all['csfrtoken']));
  request.cookies.add(Cookie("sessionid", all['sessionid']));

  request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
  request.headers.set('x-csrftoken', all['csfrtoken']);
  request.headers.set('referer', "http://159.65.157.59/");
  final response = await request.close();
  if(response.statusCode == 200){
    var temp;
    await response.transform(Utf8Decoder()).listen((value) {}).onData((data) {
      temp = json.decode(data);
    });
    return temp;
  }
  else if(response.statusCode==204){
    return '204';
  }
  else {
    print("Try again");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", false);
    final all = await _storage.deleteAll();
    return null;
  }
}catch(e){
print(e);

}
}