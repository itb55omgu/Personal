import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logintask/models/user.dart';

import '../exeption/our_exeption.dart';
import '../models/super_login.dart';
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
class UserService {
  late http.Response response;

  Future<SuperLogin> getSuperLogin(String username, String password) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var uri = mwUri('login');

    final body=stringToBase64.encode("{\"login\":\"$username\",\"password\":\"$password\"}");
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
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return SuperLogin.fromJson(json);
    } else {
      var error=Error.fromJson(json);
      throw OurException.fromBody(response.statusCode,error.errorData);
    }

  }
}

