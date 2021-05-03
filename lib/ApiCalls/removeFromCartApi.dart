import 'dart:convert';
import '../constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:io';

final _storage = FlutterSecureStorage();

Future removeFromCart(int Productid) async {
  final Map body = {
    "Productid" : Productid
  };
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(domain+"/removefromcart/"));
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

Future removeFromWishlist(int Productid) async {
  final Map body = {
    "Productid" : Productid
  };
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(domain+"/removefromwishlist/"));
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