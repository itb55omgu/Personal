import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logintask/exeption/our_exeption.dart';


import '../models/error.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
Uri mwUri(String method) {
  return Uri(
      scheme: 'http',
      host: 'localhost',
      path: '/hrm/hs/api/mw/$method',
      port: 80);
}
class PhoneNumberVerification {
  late http.Response response;

  Future<bool> verify(String phoneNumber) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var uri = mwUri('verify');
    final body=stringToBase64.encode("{\"phoneNumber\":\"$phoneNumber\"}");
    try {
      if (kDebugMode) await Future.delayed(const Duration(seconds: 1));
      response = await http.post(uri,
          headers: {
            'Authorization': 'Basic 0KHQvtC70L7Qv9C+0LLQsNCeOjE3NzY=',
            'Content-Type': 'application/json',
          },
          body: body).timeout( Duration(seconds: OurException.kHttpTimeout),
        onTimeout: () => throw TimeoutException(null),);
    } on Exception catch (e) {
      throw OurException(500, e.toString());
    } catch (o) {
      throw OurException(-1, o.toString());

    }
print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    if(response.statusCode==401) {
      return false;
    }
    else
   {
     var error=Error.fromJson(json);
      throw OurException.fromBody(response.statusCode,error.errorData);
    }

  }
}

