import 'dart:async';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants.dart';
import 'dart:convert';


final _storage = FlutterSecureStorage();

Future<String> logout() async {
  final client = HttpClient();
  final request = await client.postUrl(Uri.parse(domain+"/userlogout/"));
  final all = await _storage.readAll();
  request.cookies.add(Cookie("csrftoken",all['csfrtoken']));
  request.cookies.add(Cookie("sessionid",all['sessionid']));

  request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
  request.headers.set('x-csrftoken', all['csfrtoken']);
  request.headers.set('referer', "http://159.65.157.59/");
  final response = await request.close();
    String reply = await response.transform(utf8.decoder).join();

    return reply;

}
