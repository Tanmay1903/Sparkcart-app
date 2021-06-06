import 'dart:convert';
import '../constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

final _storage = FlutterSecureStorage();

Future AddAddressApi(String address) async {

  final Map body = {
    "address":{
      "address": address
    }
  };
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(domain+"/address/"));
  final all = await _storage.readAll();
  request.cookies.add(Cookie("csrftoken",all['csfrtoken']));
  request.cookies.add(Cookie("sessionid",all['sessionid']));

  request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
  request.headers.set('x-csrftoken', all['csfrtoken']);
  request.headers.set('referer', "http://159.65.157.59/");
  request.add(utf8.encode(json.encode(body)));
  final response = await request.close();
  return response.statusCode;

}

Future getAddresses(Function(Map temp) setAddress) async {
  try{
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(domain + "/addresslist/"));
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
    setAddress(temp);
  }
  else if(response.statusCode==204){
    setAddress({});
  }
  else {
    print("Try again");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", false);
    final all = await _storage.deleteAll();
    setAddress({});
  }
}catch(e){
    setAddress({"message": "Please check your internet connection"});

}
}

Future DeleteAddress(String address) async {
  final Map body = {
    "address":{
      "address": address
    }
  };
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(domain+"/addressdel/"));
  final all = await _storage.readAll();
  request.cookies.add(Cookie("csrftoken",all['csfrtoken']));
  request.cookies.add(Cookie("sessionid",all['sessionid']));

  request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
  request.headers.set('x-csrftoken', all['csfrtoken']);
  request.headers.set('referer', "http://159.65.157.59/");
  request.add(utf8.encode(json.encode(body)));
  final response = await request.close();
  return response.statusCode;
}

Future EditAddress(String new_address, String old_address) async {
  final Map body = {
    "new_address": new_address,
    "address":{
      "address": old_address
    }
  };
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(domain+"/addressupdate/"));
  final all = await _storage.readAll();
  request.cookies.add(Cookie("csrftoken",all['csfrtoken']));
  request.cookies.add(Cookie("sessionid",all['sessionid']));

  request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
  request.headers.set('x-csrftoken', all['csfrtoken']);
  request.headers.set('referer', "http://159.65.157.59/");
  request.add(utf8.encode(json.encode(body)));
  final response = await request.close();
  print(response.statusCode);
  return response.statusCode;
}