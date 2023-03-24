import 'dart:convert';
import 'dart:io';

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logintask/exeption/fatal_error.dart';

import '../exeption/our_exeption.dart';
import 'package:http/http.dart' as http;

import '../models/send.dart';


const String sdKey = 'ab6cfc59-acb4-4ae5-aa8e-16906db14e41';

class MwProviderOktell {
  http.Response? response;

  Uri mwUri(String method, {Map<String, String>? params}) {
    print("uri!");

    return Uri(
        scheme: 'http',
        host: '192.168.1.6',
        path: '/HRM/hs/api/oktell',
        //port: 0,
        queryParameters: params);
  }

  Map<String, String> mwHeaders() {
    print("headers!");
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          'Basic 0KfRg9C80LvRj9C60L7QstCw0KLQnjo3MjE1',
    };
  }

  ///Сервисы
  Future<SendUnit> loadPhone({
    String phone = "",
  }) async {
    final Uri uri = mwUri('oktell', params: {
      'phone': phone,
    });
    try {
      print("get1!");
      if (kDebugMode) await Future.delayed(const Duration(seconds: 1));
      response = await http.Client().get(uri, headers: mwHeaders()).timeout(
            Duration(seconds: OurException.kHttpTimeout),
            onTimeout: () => throw TimeoutException(null),
          );
      print("get2");
    } on Exception catch (e) {
      throw OurException(500, e.fatalErrorText());
    } catch (o) {
      throw OurException(-1, o.toString());
    }

    try {
      if (response!.statusCode == 200) {
        print(response!.statusCode);
        Map<String, dynamic> _body =
            json.decode(utf8.decode(response!.bodyBytes));
        print(SendUnit.fromJson(_body));
        return SendUnit.fromJson(_body);
      } else {
        throw OurException.fromResponse(response!);
      }
    } catch (e) {
      throw (e is OurException) ? e : OurException(-1, e.toString());
    }
  }
}
